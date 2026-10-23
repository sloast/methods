import 'package:flutter/material.dart';
import 'package:methods/ui/edit.dart';
import 'package:methods/ui/review.dart';
import 'package:methods/util/util.dart';
import 'package:provider/provider.dart';

import '../core/method.dart';
import '../core/model.dart';
import '../db/repo.dart';
import '../ui/diagram.dart';

class MethodViewPage extends StatefulWidget {
  MethodViewPage({super.key, required this.method});

  final Method method;
  late final ParsedMethod parsedMethod = parsePlaceNotation(
    method.placeNotation,
  );

  @override
  State<MethodViewPage> createState() => _MethodViewPageState();
}

class _MethodViewPageState extends State<MethodViewPage> {
  late final Repository repo = context.read();
  AnimationStatus _menuStatus = .dismissed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.method.name),
        actions: [
          MenuAnchor(
            animated: true,
            onAnimationStatusChanged: (s) => _menuStatus = s,
            menuChildren: [
              MenuItemButton(
                leadingIcon: Icon(Icons.rocket_launch_rounded),
                child: Text('Practice'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => PracticePage(method: widget.method),
                    ),
                  );
                },
              ),

              MenuItemButton(
                leadingIcon: Icon(Icons.add),
                child: Text('Create deck'),
                onPressed: () async {
                  await repo.createDeck(widget.method);
                  if (context.mounted) {
                    snackbar(context, "Created deck for ${widget.method.name}");
                  }
                },
              ),

              if (widget.method.isCustomMethod)
                MenuItemButton(
                  leadingIcon: Icon(Icons.edit),
                  child: Text('Edit'),
                  onPressed: () async {
                    final r = await context.push(
                      (_) => EditPage(method: widget.method),
                    );
                    if (r == true && context.mounted) context.pop();
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
        actionsPadding: .only(right: 8),
      ),
      body: MethodDiagram(parsedMethod: widget.parsedMethod),
    );
  }
}
