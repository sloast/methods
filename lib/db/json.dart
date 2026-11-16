import 'package:dart_mappable/dart_mappable.dart';
import 'package:drift/drift.dart';

import 'user/database.dart';

part 'json.mapper.dart';

@MappableClass()
class JsonExport with JsonExportMappable {
  final List<Map<String, dynamic>> methods;
  final List<Map<String, dynamic>> cards;
  final List<Map<String, dynamic>> reviewLogs;

  JsonExport({
    required this.methods,
    required this.cards,
    required this.reviewLogs,
  });
}

extension JsonExtension on UserDatabase {
  Future<String> exportJson() async {
    final JsonExport jr = await transaction(() async {
      final methods = this.methods.select().get();
      final cards = this.cards.select().get();
      final reviewLogs = this.reviewLogs.select().get();

      return JsonExport(
        methods: (await methods).map((x) => x.toJson()).toList(),
        cards: (await cards).map((x) => x.toJson()).toList(),
        reviewLogs: (await reviewLogs).map((x) => x.toJson()).toList(),
      );
    });

    return jr.toJson();
  }

  Future<void> importJson(String data) async {
    final JsonExport jr = JsonExportMapper.fromJson(data);

    for (final card in jr.cards) {
      card.putIfAbsent("method", () => card["deck"]);
      card.remove("deck");
    }

    final methods = jr.methods.map(Method.fromJson);
    final cards = jr.cards.map(Card.fromJson);
    final reviewLogs = jr.reviewLogs.map(ReviewLog.fromJson);

    await reset();
    await batch((batch) async {
      batch.insertAll(this.methods, methods);
      batch.insertAll(this.cards, cards);
      batch.insertAll(this.reviewLogs, reviewLogs);
    });
  }
}
