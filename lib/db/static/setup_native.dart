import 'dart:io';

import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'database.dart';

Future<String> _setupConnection() async {
  const int dbVersion = 1;

  final directory = await getApplicationSupportDirectory();

  final dbPath = p.join(directory.path, 'method_library.sqlite');
  final dbFile = File(dbPath);
  final versionFile = File(
    p.join(directory.path, 'method_library_version.txt'),
  );

  if (!dbFile.existsSync() ||
      !versionFile.existsSync() ||
      versionFile.readAsStringSync() != dbVersion.toString()) {
    ByteData data = await rootBundle.load("assets/method_library.sqlite");
    await dbFile.writeAsBytes(
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
    );
    await versionFile.writeAsString(dbVersion.toString());
  }
  return dbPath;
}

StaticDatabase setup() {
  return StaticDatabase(
    driftDatabase(
      name: 'methods_library',
      native: DriftNativeOptions(databasePath: _setupConnection),
    ),
  );
}
