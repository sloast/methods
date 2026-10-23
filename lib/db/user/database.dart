import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:fsrs/fsrs.dart' as fsrs;

import '../../core/model.dart' show CardType;

import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: tables)
class UserDatabase extends _$UserDatabase {
  UserDatabase([QueryExecutor? executor])
    : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  Future<void> reset() async {
    await customStatement('PRAGMA foreign_keys = OFF');

    final m = Migrator(this);
    for (final table in allTables) {
      await m.deleteTable(table.actualTableName);
      await m.createTable(table);
    }

    await customStatement('PRAGMA foreign_keys = ON');
  }

  static Future<String> getDbPath() async =>
      p.join((await getApplicationDocumentsDirectory()).path, 'methods.sqlite');

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'methods',
      native: DriftNativeOptions(databasePath: getDbPath),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    );
  }

  Future<void> import(Uint8List data) async {
    await customStatement('PRAGMA wal_checkpoint(TRUNCATE)');
    await close();
    await File(await getDbPath()).writeAsBytes(data);
  }

  Future<Uint8List> export() async {
    await customStatement('PRAGMA wal_checkpoint(TRUNCATE)');
    return await File(await getDbPath()).readAsBytes();
  }

  // Queries

  Expression<bool> get cardFilter {
    final now = DateTime.now();
    final time = DateTime(now.year, now.month, now.day).add(Duration(days: 1));
    return cards.due.isSmallerThanValue(time) & cards.paused.not();
  }

  Future<(Card, Deck)?> nextCard({bool unlearned = true}) async {
    final query =
        select(cards).join([innerJoin(decks, decks.id.equalsExp(cards.deck))])
          ..where(unlearned ? cardFilter : cardFilter & cards.learned)
          ..orderBy([OrderingTerm.asc(cards.lastReview, nulls: .first)])
          ..limit(1);
    final result = await query.getSingleOrNull();
    if (result == null) return null;
    return (result.readTable(cards), result.readTable(decks));
  }
}
