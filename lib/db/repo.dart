import 'package:drift/drift.dart';
import 'package:fsrs/fsrs.dart' as fsrs;

import '../core/method.dart';
import '../core/model.dart' as m;
import '../util/util.dart';
import 'static/database.dart' as s;
import 'user/database.dart';

class Repository {
  UserDatabase udb;
  final s.StaticDatabase sdb;

  Repository(this.udb, this.sdb);

  Future<void> close() => Future.wait([udb.close(), sdb.close()]);

  // Method

  Future<List<m.Method>> listMethods() async {
    final stmt = udb.methods.select();
    final res = await (stmt..limit(100)).get();
    return res.map(toMethod).toList();
  }

  Future<List<m.MethodData>> searchMethodLibrary(
    String search, {
    int limit = 100,
  }) async {
    search = search.replaceAll('*', '%').replaceAll('?', '_');
    final res = await sdb.search("$search%", limit).get();
    return res.map(sToMethodData).toList();
  }

  Future<m.Method?> getMethodByPlaceNotation(String placeNotation) async {
    final res =
        await (udb.methods.select()
              ..where((m) => m.placeNotation.equals(placeNotation))
              ..limit(1))
            .getSingleOrNull();

    return res.map(toMethod);
  }

  Future<m.Method?> getMethod(int id) async {
    return (await (udb.methods.select()
              ..where((m) => m.id.equals(id))
              ..limit(1))
            .getSingleOrNull())
        ?.toMethod();
  }

  Future<m.MethodData?> getLibraryMethod(int id) async {
    return (await sdb.get(id).getSingleOrNull())?.toMethodData();
  }

  Future<m.Method> createMethod({
    required String name,
    required String placeNotation,
    required int stage,
  }) async {
    return toMethod(
      await udb.methods.insertReturning(
        MethodsCompanion.insert(
          name: name,
          placeNotation: placeNotation,
          stage: stage,
          hasDeck: false,
        ),
      ),
    );
  }

  Future<void> updateMethod(m.Method method) async {
    final row = Method(
      id: method.id,
      name: method.data.name,
      placeNotation: method.data.placeNotation,
      stage: method.data.stage,
      libraryId: method.data.libraryId,
      hasDeck: method.hasDeck,
      deckSettings: null,
    );
    await (udb.methods.replaceOne(row));
  }

  // Deck

  Future<List<m.Method>> listDecks() async {
    return (await udb.listDecks()).map(toMethod).toList();
  }

  Future<List<(m.Method, int)>> listDecksAndDueCount() async {
    return (await udb.listDecksAndDueCount())
        .map2((m, c) => (m.toMethod(), c))
        .toList();
  }

  Future<m.Method> createDeck(
    m.MethodData method, {
    int? methodId,
    bool createCards = true,
  }) async {
    return await udb.transaction(() async {
      Method? m;
      if (methodId != null) {
        final x =
            await (udb.methods.update()..where((m) => m.id.equals(methodId)))
                .write(MethodsCompanion(hasDeck: .new(true)));
        if (x == 1) {
          m = await (udb.methods.select()..where((m) => m.id.equals(methodId)))
              .getSingle();
        } else {
          assert(x == 0);
        }
      }
      m ??= await udb.methods.insertReturning(
        MethodsCompanion.insert(
          name: method.name,
          placeNotation: method.placeNotation,
          stage: method.stage,
          libraryId: .absentIfNull(method.libraryId),
          hasDeck: true,
        ),
      );

      if (createCards) {
        await this.createCards(
          m.id,
          parsePlaceNotation(method.placeNotation).insideBells,
        );
      }
      return m.toMethod();
    });
  }

  Future<void> updateDeck(int id, {String? settings}) async {
    await (udb.methods.update()..where((m) => m.id.equals(id))).write(
      MethodsCompanion(deckSettings: .absentIfNull(settings)),
    );
  }

  Future<void> deleteDeck(int id) async {
    // TODO: handle custom methods better
    await udb.methods.deleteWhere((m) => m.id.equals(id));
  }

  // Card

  Future<List<m.MethodCard>> listCards({int? methodId}) async {
    final query = udb.select(udb.cards);
    if (methodId != null) query.where((c) => c.method.equals(methodId));
    return (await query.get()).map(toCard).toList();
  }

  Future<(m.MethodCard, m.Method)?> nextCard() async {
    final res = await udb.nextCard(unlearned: true);
    if (res == null) return null;
    final (c, m) = res;

    return (c.toCard(), m.toMethod());
  }

  Future<void> createCards(int method, List<int> placeBells) async {
    await udb.cards.insertAll(
      placeBells.map(
        (x) => CardsCompanion.insert(
          state: .learning,
          due: .now(),
          method: method,
          type: .placeBell,
          placeBell: x,
          paused: false,
          learned: true,
        ),
      ),
    );
  }

  Future<void> updateCard(
    int id, {
    fsrs.Card? card,
    bool? paused,
    bool? learned,
  }) async {
    await (udb.cards.update()..where((c) => c.id.equals(id))).write(
      CardsCompanion(
        state: .absentIfNull(card?.state),
        step: .absentIfNull(card?.step),
        stability: .absentIfNull(card?.stability),
        difficulty: .absentIfNull(card?.difficulty),
        due: .absentIfNull(card?.due),
        lastReview: .absentIfNull(card?.lastReview),
        paused: .absentIfNull(paused),
        learned: .absentIfNull(learned),
      ),
    );
  }

  Future<void> createReviewLog(fsrs.ReviewLog l) async {
    await udb.reviewLogs.insertOne(
      ReviewLogsCompanion.insert(
        card: l.cardId,
        rating: l.rating,
        reviewDateTime: l.reviewDateTime,
        reviewDuration: .absentIfNull(l.reviewDuration),
      ),
    );
  }

  // Conversions
  m.MethodData sToMethodData(s.Method m) => m.toMethodData();
  m.Method toMethod(Method m) => m.toMethod();
  m.MethodCard toCard(Card c) => c.toCard();
}

extension SToMethod on s.Method {
  m.MethodData toMethodData() => m.MethodData(
    name: name,
    placeNotation: placeNotation,
    stage: stage,
    libraryId: id,
  );
}

extension UToMethod on Method {
  m.Method toMethod() => m.Method(
    id: id,
    data: m.MethodData(
      name: name,
      placeNotation: placeNotation,
      stage: stage,
      libraryId: libraryId,
    ),
    hasDeck: hasDeck,
  );
}

extension ToCard on Card {
  m.MethodCard toCard() => m.MethodCard(
    id: id,
    card: fsrs.Card(
      cardId: id,
      state: state,
      step: step,
      stability: stability,
      difficulty: difficulty,
      due: due,
      lastReview: lastReview,
    ),
    method: method,
    type: type,
    placeBell: placeBell,
    paused: paused,
    learned: learned,
  );
}
