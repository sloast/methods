import 'package:dart_mappable/dart_mappable.dart';
import 'package:drift/drift.dart';

import 'user/database.dart';

part 'json.mapper.dart';

@MappableClass()
class JsonRepo with JsonRepoMappable {
  final List<Map<String, dynamic>> decks;
  final List<Map<String, dynamic>> cards;
  final List<Map<String, dynamic>> reviewLogs;

  JsonRepo(this.decks, this.cards, this.reviewLogs);
}

extension JsonExtension on UserDatabase {
  Future<String> exportJson() async {
    final jr = await transaction(() async {
      final decks = this.decks.select().get();
      final cards = this.cards.select().get();
      final reviewLogs = this.reviewLogs.select().get();

      return JsonRepo(
        (await decks).map((x) => x.toJson()).toList(),
        (await cards).map((x) => x.toJson()).toList(),
        (await reviewLogs).map((x) => x.toJson()).toList(),
      );
    });

    return jr.toJson();
  }

  Future<void> importJson(String data) async {
    final jr = JsonRepoMapper.fromJson(data);

    final decks = jr.decks.map(Deck.fromJson);
    final cards = jr.cards.map(Card.fromJson);
    final reviewLogs = jr.reviewLogs.map(ReviewLog.fromJson);

    await reset();
    await batch((batch) async {
      batch.insertAll(this.decks, decks);
      batch.insertAll(this.cards, cards);
      batch.insertAll(this.reviewLogs, reviewLogs);
    });
  }
}
