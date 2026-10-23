import 'package:drift/drift.dart';

part 'database.g.dart';

@DriftDatabase(include: {'tables.drift'})
class StaticDatabase extends _$StaticDatabase {
  StaticDatabase(super.executor);

  @override
  int get schemaVersion => 1;
}
