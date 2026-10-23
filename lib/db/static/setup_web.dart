import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/services.dart';
import 'package:methods/db/static/database.dart';

StaticDatabase setup() {
  return StaticDatabase(
    driftDatabase(
      name: 'methods_library',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
        initializeDatabase: () async {
          ByteData data = await rootBundle.load("assets/method_library.sqlite");
          return data.buffer.asUint8List(
            data.offsetInBytes,
            data.lengthInBytes,
          );
        },
      ),
    ),
  );
}
