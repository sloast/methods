import 'package:flutter/material.dart';
import 'package:fsrs/fsrs.dart' as fsrs;
import 'package:methods/core/prefs.dart';
import 'package:methods/db/repo.dart';
import 'package:methods/db/static/setup.dart' as static_db_setup;
import 'package:methods/db/user/database.dart' show UserDatabase;
import 'package:methods/ui/home.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final prefs = await Prefs.create();

    runApp(
      MultiProvider(
        providers: [
          Provider<Repository>(
            create: (_) => Repository(UserDatabase(), static_db_setup.setup()),
            dispose: (_, db) => db.close(),
          ),
          Provider<fsrs.Scheduler>(create: (_) => fsrs.Scheduler()),
          Provider<Prefs>(create: (_) => prefs),
        ],
        child: MyApp(),
      ),
    );
  } catch (e, s) {
    runApp(
      MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Text(
                'Error during initialisation: $e\n$s',
                style: .new(
                  color: Colors.red,
                  fontFamily: 'monospace',
                  fontFamilyFallback: <String>["Courier"],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    rethrow;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Methods',
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: Colors.indigo,
          brightness: .dark,
          dynamicSchemeVariant: .expressive,
        ),
        cardTheme: .new(clipBehavior: .antiAlias),
      ),
      home: const MyHomePage(),
    );
  }
}
