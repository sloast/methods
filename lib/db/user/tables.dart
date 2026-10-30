import 'package:drift/drift.dart';
import 'package:fsrs/fsrs.dart' as fsrs;

import '../../core/model.dart' show CardType;

const tables = [Cards, Methods, ReviewLogs];

@TableIndex(name: 'cardDue', columns: {#due})
@TableIndex(name: 'cardMethod', columns: {#method})
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
  IntColumn get method =>
      integer().references(Methods, #id, onDelete: .cascade)();

  TextColumn get type => textEnum<CardType>()();
  IntColumn get placeBell => integer()();

  BoolColumn get paused => boolean()();
  BoolColumn get learned => boolean()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {method, type, placeBell},
  ];

  @override
  bool get isStrict => true;
}

@TableIndex(name: 'methodName', columns: {#name})
@TableIndex(name: 'methodPlaceNotation', columns: {#placeNotation})
class Methods extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();
  TextColumn get placeNotation => text()();
  IntColumn get stage => integer()();

  IntColumn get libraryId => integer().nullable().unique()();

  // Deck
  BoolColumn get hasDeck => boolean()();
  TextColumn get deckSettings => text().nullable()();

  @override
  bool get isStrict => true;
}

@TableIndex(name: 'reviewLogCard', columns: {#card})
class ReviewLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get card => integer().references(Cards, #id, onDelete: .cascade)();
  IntColumn get rating => intEnum<fsrs.Rating>()();
  DateTimeColumn get reviewDateTime => dateTime()();
  IntColumn get reviewDuration => integer().nullable()();
}
