import 'package:dart_mappable/dart_mappable.dart';
import 'package:drift/drift.dart';

import 'user/database.dart';
import 'static/database.dart' as s;

part 'json.mapper.dart';

@MappableClass()
class JsonRepo with JsonRepoMappable {
  final List<Map<String, dynamic>>? decks;
  final List<Map<String, dynamic>>? methods;
  final List<Map<String, dynamic>> cards;
  final List<Map<String, dynamic>> reviewLogs;

  JsonRepo({
    this.decks,
    required this.methods,
    required this.cards,
    required this.reviewLogs,
  });
}

extension JsonExtension on UserDatabase {
  Future<String> exportJson() async {
    final JsonRepo jr = await transaction(() async {
      final methods = this.methods.select().get();
      final cards = this.cards.select().get();
      final reviewLogs = this.reviewLogs.select().get();

      return JsonRepo(
        methods: (await methods).map((x) => x.toJson()).toList(),
        cards: (await cards).map((x) => x.toJson()).toList(),
        reviewLogs: (await reviewLogs).map((x) => x.toJson()).toList(),
      );
    });

    return jr.toJson();
  }

  Future<void> importJson(String data, s.StaticDatabase sdb) async {
    final JsonRepo jr = JsonRepoMapper.fromJson(data);

    for (final card in jr.cards) {
      card.putIfAbsent("method", () => card["deck"]);
      card.remove("deck");
    }

    final methods = jr.methods?.map(Method.fromJson);
    final cards = jr.cards.map(Card.fromJson);
    final reviewLogs = jr.reviewLogs.map(ReviewLog.fromJson);

    final decks = jr.decks?.map((d) async {
      final int id = d["id"];
      final int libraryId = d["method"];
      final s.Method libraryMethod = await sdb.get(libraryId).getSingle();
      return Method(
        id: id,
        name: libraryMethod.name,
        placeNotation: libraryMethod.placeNotation,
        stage: libraryMethod.stage,
        libraryId: libraryMethod.id,
        hasDeck: true,
      );
    });

    await reset();
    await batch((batch) async {
      if (methods != null) {
        batch.insertAll(this.methods, methods);
      }
      if (decks != null) {
        batch.insertAll(this.methods, await Future.wait(decks));
      }
      batch.insertAll(this.cards, cards);
      batch.insertAll(this.reviewLogs, reviewLogs);
    });
  }
}
