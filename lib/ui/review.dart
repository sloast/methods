import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fsrs/fsrs.dart' as fsrs;
import 'package:methods/core/prefs.dart';
import 'package:provider/provider.dart';

import '../core/method.dart';
import '../core/model.dart';
import '../db/repo.dart';
import '../util/util.dart';

import 'diagram.dart';

enum ReviewState { learning, reviewing, done }

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  static final ratings = [
    (fsrs.Rating.again, Icons.replay_rounded),
    (fsrs.Rating.hard, Icons.warning_amber_rounded),
    (fsrs.Rating.good, Icons.thumb_up_rounded),
    (fsrs.Rating.easy, Icons.emoji_emotions_rounded),
  ];
  late final Repository repo = context.read();

  MethodCard? mcard;
  MethodDeck? deck;
  Method? method;
  ParsedMethod? parsedMethod;

  ReviewState state = .reviewing;
  int errors = 0;
  fsrs.Rating rating = .again;

  HashMap<fsrs.Rating, ({fsrs.Card card, fsrs.ReviewLog reviewLog})> reviewed =
      .new();

  Future<void> nextCard() async {
    final next = await repo.nextCard();
    if (next == null) {
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("No more reviews")));
      }
      return;
    }
    final (c, d) = next;

    if (d.method != method?.id) {
      method = await repo.getMethod(id: d.method, custom: d.isCustomMethod);
      parsedMethod = method?.parse();
    }

    setState(() {
      mcard = c;
      deck = d;
      state = .reviewing;
    });
  }

  Future<void> review(fsrs.Scheduler scheduler) async {
    final c = mcard;
    if (c == null) return;
    final (:card, :reviewLog) = reviewed[rating]!;
    Future.wait([
      repo.updateCard(c.id, card: card),
      repo.createReviewLog(reviewLog),
    ]);
    await nextCard();
  }

  @override
  void initState() {
    super.initState();
    nextCard();
  }

  @override
  Widget build(BuildContext context) {
    final fsrs.Scheduler scheduler = context.watch();

    done(int errors) async {
      setState(() {
        for (final (r, _) in ratings) {
          reviewed[r] = scheduler.reviewCard(mcard!.card, r);
        }
        state = .done;
        this.errors = errors;
        rating = switch (errors) {
          0 => .good,
          _ => .again,
        };
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text(method?.name ?? deck?.name ?? 'Review')),
      body: SafeArea(
        child: parsedMethod != null && method != null
            ? switch (state) {
                .learning => Text('new'),

                .reviewing => DrawBlueline(
                  name: method!.name,
                  method: parsedMethod!,
                  placeBell: mcard!.placeBell,
                  onDone: done,
                ),

                .done => Column(
                  spacing: 40,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          errors == 0 ? "OK" : "$errors errors",
                          style: context.textTheme.displayMedium?.copyWith(
                            color: errors == 0 ? Colors.green : Colors.red,
                          ),
                        ),
                      ),
                    ),
                    FilledButton.tonalIcon(
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(120, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: .all(.circular(15)),
                        ),
                        textStyle: context.textTheme.labelLarge,
                      ),
                      onPressed: () => review(scheduler),
                      icon: Icon(Icons.check),
                      label: Text('Continue'),
                    ),
                    Container(
                      alignment: .center,
                      padding: .only(bottom: 20),
                      child: SegmentedButton<fsrs.Rating>(
                        expandedInsets: EdgeInsets.symmetric(horizontal: 10),
                        style: SegmentedButton.styleFrom(
                          visualDensity: VisualDensity.standard,
                          selectedForegroundColor: Colors.black,
                          selectedBackgroundColor: switch (rating) {
                            .again => Colors.red.shade400,
                            .hard => Colors.amber,
                            .good => Colors.green,
                            .easy => Colors.blue.shade400,
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: .all(.circular(15)),
                          ),
                        ),
                        selected: .of([rating]),
                        onSelectionChanged: (s) {
                          setState(() => rating = s.first);
                        },
                        showSelectedIcon: false,
                        segments: ratings
                            .map2(
                              (value, icon) => ButtonSegment(
                                value: value,
                                icon: Icon(icon),
                                label: Column(
                                  children: [
                                    Text(
                                      value.name.capitalize(),
                                      softWrap: false,
                                    ),
                                    Text(
                                      (() {
                                        final c = mcard?.card;
                                        if (c == null) return '-';
                                        final (:card, :reviewLog) =
                                            reviewed[value]!;
                                        final time = card.due.difference(
                                          reviewLog.reviewDateTime,
                                        );
                                        return time.format();
                                      })(),
                                      softWrap: false,
                                      style: TextStyle(
                                        fontWeight: .normal,
                                        fontSize: context
                                            .textTheme
                                            .bodySmall
                                            ?.fontSize,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              }
            : Text(
                'ERROR: Method ${deck?.name} not found. Update the app or delete this deck.',
              ),
      ),
    );
  }
}

class PracticePage extends StatefulWidget {
  PracticePage({super.key, required this.method, this.placeBell});

  final Method method;
  final int? placeBell;
  late final parsed = method.parse();

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  late int? placeBell = widget.placeBell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.method.name)),
      body: SafeArea(
        child: DrawBlueline(
          name: widget.method.name,
          method: widget.parsed,
          placeBell: placeBell ?? widget.parsed.insideBells[0],
          onDone: (_) => context.pop(),
        ),
      ),
    );
  }
}

class DrawBlueline extends StatefulWidget {
  const DrawBlueline({
    super.key,
    required this.name,
    required this.method,
    required this.placeBell,
    required this.onDone,
  });

  final String name;
  final ParsedMethod method;
  final int placeBell;
  final void Function(int) onDone;

  @override
  State<StatefulWidget> createState() => _DrawBluelineState();
}

class _DrawBluelineState extends State<DrawBlueline> {
  late final Prefs prefs = context.read();

  final FocusNode _focusNode = FocusNode();
  late final _scrollController = ScrollController();
  late final List<List<int>> rows = widget.method.rows.toList();

  int step = 0;
  int errors = 0;

  void scrollDown() {
    if (_scrollController.hasClients &&
        _scrollController.positions.length == 1) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: .new(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void error() {
    HapticFeedback.heavyImpact();
    setState(() {
      errors++;
    });
  }

  bool input(int direction) {
    if (step >= rows.length - 1) {
      error();
      return false;
    }
    final int pos = rows[step].indexOf(widget.placeBell);
    final int next = pos + direction;
    final row = rows[step + 1];
    if (next < 0 ||
        next >= row.length ||
        row.elementAtOrNull(next) != widget.placeBell) {
      error();
      return false;
    }
    setState(() {
      step++;
    });
    if (step == rows.length - 1 && !prefs.manualFinish) {
      Future.delayed(.new(milliseconds: 250), () {
        widget.onDone(errors);
      });
    }
    return true;
  }

  void longInput(int direction) {
    if (direction == 0) {
      input(0);
      return;
    }
    for (int i = 0; i < 100; i++) {
      if (!input(direction)) break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget makeButton(
      int direction,
      IconData icon, {
      OutlinedBorder? border,
      BorderRadiusGeometry? radius,
      bool expand = true,
    }) {
      final w = IconButton.outlined(
        style: .new(
          shape: .all(
            border ??
                RoundedRectangleBorder(
                  borderRadius: radius ?? BorderRadius.circular(20),
                ),
          ),
        ),
        onPressed: () => input(direction),
        onLongPress: () => longInput(direction),
        icon: Icon(icon),
      );
      return expand ? Expanded(child: w) : w;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => scrollDown());
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (e) {
        if (e is! KeyDownEvent) return;
        switch (e.logicalKey) {
          case .arrowLeft:
            input(-1);
          case .arrowDown:
            input(0);
          case .arrowRight:
            input(1);
        }
      },
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) => ListView(
                padding: .only(
                  bottom: 100,
                  top: max(constraints.maxHeight - 250, 0),
                ),
                controller: _scrollController,
                children: [
                  Column(
                    crossAxisAlignment: .center,
                    children: [
                      Text(
                        widget.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        '${ordinalString(widget.placeBell + 1)} place bell',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      DiagramContainer(
                        method: rows.take(step + 1).followedBy([
                          List.filled(widget.method.stage, -1),
                        ]).toList(),
                        huntBells: widget.method.huntBells,
                        insideBells: [widget.placeBell],
                        leadLength: step >= rows.length - 1
                            ? widget.method.length
                            : 0,
                        drawNums: false,
                        drawLeadEnds: !prefs.manualFinish,
                        hideTreble: prefs.hideTreble,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: Row(
              crossAxisAlignment: .stretch,
              children: [
                makeButton(
                  -1,
                  Icons.keyboard_arrow_left_rounded,
                  radius: .only(topLeft: .circular(20)),
                ),
                makeButton(
                  1,
                  Icons.keyboard_arrow_right_rounded,
                  radius: .only(topRight: .circular(20)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
            child: makeButton(
              0,
              Icons.keyboard_arrow_down_rounded,
              radius: .vertical(bottom: .circular(20)),
              expand: false,
            ),
          ),
          SizedBox(
            height: 100,
            child: prefs.manualFinish
                ? Padding(
                    padding: .only(top: 25),
                    child: OutlinedButton(
                      style: .new(
                        shape: .all(
                          RoundedRectangleBorder(borderRadius: .circular(20)),
                        ),
                      ),
                      onPressed: () {
                        if (step == rows.length - 1) {
                          widget.onDone(errors);
                        } else {
                          error();
                        }
                      },
                      child: Text('Done'),
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
