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
  final prefs = await Prefs.create();
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => Repository(UserDatabase(), static_db_setup.setup()),
        ),
        Provider(create: (_) => fsrs.Scheduler()),
        Provider(create: (_) => prefs),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Methods',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.purple, brightness: .dark),
        cardTheme: .new(clipBehavior: .antiAlias),
      ),
      home: const MyHomePage(),
    );
  }
}
