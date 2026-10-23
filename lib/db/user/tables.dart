import 'package:drift/drift.dart';
import 'package:fsrs/fsrs.dart' as fsrs;

import '../../core/model.dart' show CardType;

const tables = [Cards, Decks, CustomMethods, ReviewLogs];

@TableIndex(name: 'cardDue', columns: {#due})
@TableIndex(name: 'cardDeck', columns: {#deck})
class Cards extends Table {
  IntColumn get id => integer().autoIncrement()();

  // fsrs
  IntColumn get state => intEnum<fsrs.State>()();
  IntColumn get step => integer().nullable()();
  RealColumn get stability => real().nullable()();
  RealColumn get difficulty => real().nullable()();
  DateTimeColumn get due => dateTime()();
  DateTimeColumn get lastReview => dateTime().nullable()();

  // meta
  IntColumn get deck => integer().references(Decks, #id, onDelete: .cascade)();

  TextColumn get type => textEnum<CardType>()();
  IntColumn get placeBell => integer()();

  BoolColumn get paused => boolean()();
  BoolColumn get learned => boolean()();

  @override
  bool get isStrict => true;
}

@TableIndex(name: 'deckMethod', columns: {#method, #custom})
class Decks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  BoolColumn get custom => boolean()();
  IntColumn get method => integer()();

  TextColumn get settings => text()();

  @override
  bool get isStrict => true;
}

@TableIndex(name: 'customMethodPN', columns: {#placeNotation})
class CustomMethods extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();
  TextColumn get placeNotation => text()();
  IntColumn get stage => integer()();

  @override
  bool get isStrict => true;
}

class ReviewLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get card => integer().references(Cards, #id, onDelete: .cascade)();
  IntColumn get rating => intEnum<fsrs.Rating>()();
  DateTimeColumn get reviewDateTime => dateTime()();
  IntColumn get reviewDuration => integer().nullable()();
}
