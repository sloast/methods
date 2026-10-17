import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;
import 'package:flutter/material.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart' as fuzzy;
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:methods/core/model.dart';
import 'package:methods/core/prefs.dart';
import 'package:methods/db/user/database.dart' as udb;
import 'package:methods/ui/method.dart';
import 'package:provider/provider.dart';

import '../db/repo.dart';
import '../util/util.dart';

import 'deck.dart';
import 'edit.dart';
import 'review.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static const List<NavigationDestination> destinations =
      <NavigationDestination>[
        NavigationDestination(
          label: 'Decks',
          icon: Icon(Icons.library_books_outlined),
          selectedIcon: Icon(Icons.library_books),
        ),
        NavigationDestination(
          label: 'Methods',
          icon: Icon(Icons.search_rounded),
        ),
        NavigationDestination(
          label: 'Options',
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
        ),
      ];

  late final Repository repo = context.read();
  late final Prefs prefs = context.read();

  late final allMethods = repo.searchMethods("", limit: 99999);
  final searchController = TextEditingController();
  String? searchQuery;
  late Future<List<(MethodDeck, int)>> decks;
  late Future<List<Method>> methods;

  int currentPageIndex = 0;

  void reload([dynamic _]) {
    decks = repo.listDecksAndDueCount();
    runSearch();
  }

  void runSearch([String? query]) {
    final q = (searchQuery = query ?? searchQuery ?? '').toLowerCase();
    setState(() {
      methods = () async {
        final a = await allMethods;

        if (kIsWeb) {
          final b = a
              .where((m) => m.name.toLowerCase().startsWith(q))
              .take(100);
          return b.toList();
        }

        final b = a.map((m) {
          final name = m.name.toLowerCase();
          return (m, fuzzy.ratio(q, name) + (name.startsWith(q) ? 50 : 0));
        }).toList();
        b.sort((x, y) => -x.$2.compareTo(y.$2));
        return b.sublist(0, min(b.length, 100)).map((m) => (m.$1)).toList();
      }();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    reload();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reload();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == .resumed) reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: currentPageIndex == 1
            ? TextField(
                controller: searchController,
                enableSuggestions: false,
                autofocus: true,
                decoration: .new(
                  hint: Text('Search methods'),
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchController.clear();
                      reload();
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
                onChanged: runSearch,
              )
            : Text(destinations[currentPageIndex].label),
      ),
      body: SafeArea(
        child: [
          // Decks
          Center(
            child: Column(
              children: [
                list(
                  decks,
                  t2<MethodDeck, int, Widget>(
                    (d, i) => Card(
                      child: ListTile(
                        leading: Icon(Icons.my_library_books_outlined),
                        title: Text(d.name),
                        onTap: () async {
                          final m = await repo.getMethodFromDeck(d);
                          if (context.mounted) {
                            if (m != null) {
                              context.push((_) => MethodViewPage(method: m));
                            } else {
                              error(context, 'Method not found');
                            }
                          }
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "$i",
                              style: context.textTheme.titleMedium?.copyWith(
                                color: switch (i) {
                                  0 => Colors.grey,
                                  _ => Colors.greenAccent,
                                },
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.settings),
                              onPressed: () => context
                                  .push((_) => DeckViewPage(deck: d))
                                  .then(reload),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ifEmpty: () => Center(
                    child: Text(
                      "You don't have any decks.\nGo to Methods and press the + next to a method to start learning.",
                      textAlign: .center,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Methods
          Center(
            child: Column(
              children: [
                list(
                  methods,
                  (m) => Card(
                    child: ListTile(
                      title: Text(m.name),
                      onTap: () async => Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (ctx) => MethodViewPage(method: m),
                            ),
                          )
                          .then(reload),
                      trailing: IconButton(
                        onPressed: () async {
                          await repo.createDeck(m);
                          if (context.mounted) {
                            snackbar(context, "Created deck for ${m.name}");
                          }
                          reload();
                        },
                        icon: Icon(Icons.add_rounded),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Settings
          Container(
            alignment: .center,
            padding: .all(10),
            child: Column(
              spacing: 10,
              children: [
                Wrap(
                  alignment: .center,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    OutlinedButton.icon(
                      icon: Icon(Icons.download),
                      label: Text('Import'),
                      onPressed: () async {
                        final file = await FilePicker.pickFile(
                          dialogTitle: 'Import methods.sqlite...',
                        );
                        if (file == null) return;
                        final data = await file.readAsBytes();
                        await repo.udb.import(data);
                        repo.udb = udb.UserDatabase();
                      },
                    ),
                    OutlinedButton.icon(
                      icon: Icon(Icons.upload),
                      label: Text('Export'),
                      onPressed: () async {
                        await FilePicker.saveFile(
                          fileName: 'methods.sqlite',
                          bytes: await repo.udb.export(),
                        );
                      },
                    ),
                    if (kDebugMode)
                      OutlinedButton.icon(
                        icon: Icon(Icons.delete_forever),
                        label: Text('Delete all data'),
                        onPressed: () async {
                          if (await yesNoDialog(
                            context,
                            'Reset Database?',
                            Text(
                              'Do not press yes unless you know what you are doing!',
                            ),
                          )) {
                            repo.udb.reset();
                          }
                        },
                      ),
                    if (kDebugMode)
                      OutlinedButton.icon(
                        icon: Icon(Icons.add),
                        label: Text('Add custom method'),
                        onPressed: () {
                          Navigator.of(context)
                              .push(
                                MaterialPageRoute(builder: (ctx) => EditPage()),
                              )
                              .then((b) {
                                if (b == true) reload();
                              });
                        },
                      ),
                  ],
                ),
                SwitchListTile(
                  title: Text("Hide treble line"),
                  value: prefs.hideTreble,
                  onChanged: (v) => setState(() => prefs.hideTreble = v),
                ),
                SwitchListTile(
                  title: Text("Auto finish review"),
                  value: prefs.autoFinish,
                  onChanged: (v) => setState(() => prefs.autoFinish = v),
                ),
              ],
            ),
          ),
        ][currentPageIndex],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => (context.push((ctx) => ReviewPage()).then(reload),),
        tooltip: 'Study',
        label: Text('Study'),
        icon: const Icon(Symbols.cards_stack),
      ),

      drawer: NavigationDrawer(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        children: [
          CloseButton(onPressed: () => Navigator.of(context).pop()),
          ...destinations.map(
            (d) => NavigationDrawerDestination(
              label: Text(d.label),
              icon: d.icon,
              selectedIcon: d.selectedIcon,
            ),
          ),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
          reload();
        },
        selectedIndex: currentPageIndex,
        destinations: destinations,
      ),
    );
  }
}
