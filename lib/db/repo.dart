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
    final stmt = udb.customMethods.select();
    final res = await (stmt..limit(100)).get();
    return res.map(cmToMethod).toList();
  }

  Future<List<m.Method>> searchMethods(String search, {int limit = 100}) async {
    search = search.replaceAll('*', '%').replaceAll('?', '_');
    final res = await sdb.search("$search%", limit).get();
    return res.map((x) => x.toMethod()).toList();
  }

  Future<m.Method?> getMethodByPlaceNotation(String placeNotation) async {
    final res =
        await (udb.select(udb.customMethods)
              ..where((m) => m.placeNotation.equals(placeNotation))
              ..limit(1))
            .getSingleOrNull();

    return res.map(cmToMethod);
  }

  Future<m.Method?> getMethod({required int id, required bool custom}) async {
    if (custom) {
      return (await (udb.select(udb.customMethods)
                ..where((m) => m.id.equals(id))
                ..limit(1))
              .getSingleOrNull())
          ?.toMethod();
    } else {
      return (await sdb.get(id).getSingleOrNull())?.toMethod();
    }
  }

  Future<m.Method?> getMethodFromDeck(m.MethodDeck deck) =>
      getMethod(id: deck.method, custom: deck.isCustomMethod);

  Future<m.Method> createCustomMethod({
    required String name,
    required String placeNotation,
    required int stage,
  }) async {
    return cmToMethod(
      await udb.customMethods.insertReturning(
        CustomMethodsCompanion.insert(
          name: name,
          placeNotation: placeNotation,
          stage: stage,
        ),
      ),
    );
  }

  Future<void> updateCustomMethod(m.Method method) async {
    await (udb.customMethods.update()..where((m) => m.id.equals(method.id)))
        .write(
          CustomMethodsCompanion.insert(
            id: .new(method.id),
            name: method.name,
            placeNotation: method.placeNotation,
            stage: method.stage,
          ),
        );
  }

  // Deck

  Future<List<m.MethodDeck>> listDecks() async {
    final res = await (udb.select(udb.decks)).get();
    return res.map(toDeck).toList();
  }

  Future<List<(m.MethodDeck, int)>> listDecksAndDueCount() async {
    final cardCount = udb.cards.id.count();
    final res =
        await (udb.select(udb.decks).join([
                leftOuterJoin(
                  udb.cards,
                  udb.cards.deck.equalsExp(udb.decks.id) & udb.cardFilter,
                ),
              ])
              ..addColumns([cardCount])
              ..groupBy([udb.decks.id]))
            .get();
    return res
        .map((r) => (toDeck(r.readTable(udb.decks)), r.read(cardCount)!))
        .toList();
  }

  Future<m.MethodDeck> createDeck(
    m.Method method, [
    bool createCards = true,
  ]) async {
    final res = toDeck(
      await udb.decks.insertReturning(
        DecksCompanion.insert(
          name: method.name,
          custom: method.isCustomMethod,
          method: method.id,
          settings: '{}',
        ),
      ),
    );
    if (createCards) {
      await this.createCards(
        res.id,
        parsePlaceNotation(method.placeNotation).insideBells,
      );
    }
    return res;
  }

  Future<m.MethodDeck?> getDeck({
    int? id,
    int? method,
    bool? isCustomMethod,
  }) async {
    assert((id != null) != (method != null));
    assert((method != null) == (isCustomMethod != null));

    var qry = udb.select(udb.decks)..limit(1);
    if (id != null) {
      qry.where((d) => d.id.equals(id));
    }
    if (method != null && isCustomMethod != null) {
      qry.where(
        (d) => d.method.equals(method) & d.custom.equals(isCustomMethod),
      );
    }
    return (await qry.getSingleOrNull()).map(toDeck);
  }

  Future<void> updateDeck(int id, {String? name, String? settings}) async {
    await (udb.decks.update()..where((m) => m.id.equals(id))).write(
      DecksCompanion(
        name: .absentIfNull(name),
        settings: .absentIfNull(settings),
      ),
    );
  }

  Future<void> deleteDeck(int id) async {
    await udb.decks.deleteWhere((d) => d.id.equals(id));
  }

  // Card

  Future<List<m.MethodCard>> listCards({int? deckId}) async {
    final query = udb.select(udb.cards);
    if (deckId != null) query.where((c) => c.deck.equals(deckId));
    return (await query.get()).map(toCard).toList();
  }

  Future<(m.MethodCard, m.MethodDeck)?> nextCard() async {
    final res = await udb.nextCard(unlearned: true);
    if (res == null) return null;
    final (c, d) = res;

    return (c.toCard(), d.toDeck());
  }

  Future<void> createCards(int deck, List<int> placeBells) async {
    await udb.cards.insertAll(
      placeBells.map(
        (x) => CardsCompanion.insert(
          state: .learning,
          due: .now(),
          deck: deck,
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
  m.Method sToMethod(s.Method m) => m.toMethod();
  m.Method cmToMethod(CustomMethod m) => m.toMethod();
  m.MethodDeck toDeck(Deck d) => d.toDeck();
  m.MethodCard toCard(Card c) => c.toCard();
}

extension ToMethod on s.Method {
  m.Method toMethod() => m.Method(
    id: id,
    name: name,
    placeNotation: placeNotation,
    stage: stage,
    isCustomMethod: false,
  );
}

extension CMToMethod on CustomMethod {
  m.Method toMethod() => m.Method(
    id: id,
    name: name,
    placeNotation: placeNotation,
    stage: stage,
    isCustomMethod: true,
  );
}

extension ToDeck on Deck {
  m.MethodDeck toDeck() =>
      m.MethodDeck(id: id, name: name, method: method, isCustomMethod: custom);
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
    deck: deck,
    type: type,
    placeBell: placeBell,
    paused: paused,
    learned: learned,
  );
}
