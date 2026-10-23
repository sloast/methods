import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fsrs/fsrs.dart' as fsrs;
import 'package:methods/ui/method.dart';
import 'package:provider/provider.dart';

import '../core/model.dart';
import '../db/repo.dart';
import '../util/util.dart';

class DeckViewPage extends StatefulWidget {
  const DeckViewPage({super.key, required this.deck});

  final MethodDeck deck;

  @override
  State<DeckViewPage> createState() => _DeckViewPageState();
}

class _DeckViewPageState extends State<DeckViewPage> {
  late final Repository repo = context.read();
  late final fsrs.Scheduler scheduler = context.read();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AnimationStatus _menuStatus = .dismissed;

  @override
  Widget build(BuildContext context) {
    void viewMethod() async {
      final m = await repo.getMethodFromDeck(widget.deck);
      if (context.mounted && m != null) {
        context.push((_) => MethodViewPage(method: m));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deck.name),
        actionsPadding: .only(right: 8),
        actions: [
          IconButton(
            icon: Icon(Icons.open_in_new_rounded),
            onPressed: viewMethod,
          ),
          MenuAnchor(
            animated: true,
            onAnimationStatusChanged: (s) => _menuStatus = s,
            menuChildren: [
              MenuItemButton(
                leadingIcon: Icon(Icons.open_in_new_rounded),
                onPressed: viewMethod,
                child: Text('View method'),
              ),
              MenuItemButton(
                leadingIcon: Icon(Icons.delete_forever),
                child: Text('Delete'),
                onPressed: () async {
                  try {
                    bool confirmed = await yesNoDialog(
                      context,
                      'Delete deck?',
                      Text(
                        'This will permanently delete all associated cards.',
                      ),
                    );
                    if (confirmed) {
                      await repo.deleteDeck(widget.deck.id);
                      if (context.mounted) Navigator.pop(context);
                    }
                  } catch (e) {
                    if (context.mounted) error(context, e);
                  }
                },
              ),
            ],
            builder: (context, controller, child) => IconButton(
              onPressed: () {
                if (_menuStatus.isForwardOrCompleted) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              icon: Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      body: list(
        repo.listCards(deckId: widget.deck.id),
        (c) => Card(
          child: ListTile(
            title: Text(switch (c.type) {
              .placeBell => '${ordinalString(c.placeBell + 1)} place bell',
            }),
            subtitle: Row(
              spacing: 8,
              children: [
                Text(
                  'D: ${c.card.difficulty?.toStringAsFixed(2)}',
                  style: .new(
                    color: c.card.difficulty.map((c) => colormap(1 - c / 10)),
                  ),
                ),
                Text(
                  'S: ${c.card.stability?.toStringAsFixed(2)}',
                  style: .new(
                    color: c.card.stability.map((c) => colormap(log(c) / 8)),
                  ),
                ),
                Text(
                  'R: ${scheduler.getCardRetrievability(c.card, currentDateTime: DateTime.now().add(.new(days: 365))).toStringAsFixed(2)}',
                  style: .new(
                    color: c.card.stability.map((c) => colormap(log(c) / 8)),
                  ),
                ),
                Text('due: ${c.card.due.difference(.now()).format(bi: true)}'),
              ],
            ),
            trailing: Switch(
              value: !c.paused,
              onChanged: (value) async {
                await repo.updateCard(c.id, paused: !value);
                setState(() {});
              },
            ),

            onTap: () => showCardInfo(context, c),
          ),
        ),
      ),
    );
  }
}

void showCardInfo(BuildContext context, MethodCard c) {
  showDialog(
    context: context,
    builder: (ctx) => Dialog.fullscreen(
      child: Padding(
        padding: .all(8),
        child: Column(
          mainAxisSize: .min,
          spacing: 8,
          children: [
            Text('Card data', style: Theme.of(ctx).textTheme.titleLarge),
            Text(c.toString()),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    ),
  );
}
