import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/method.dart';
import '../core/model.dart';
import '../db/repo.dart';
import '../ui/diagram.dart';
import '../util/util.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key, this.method});

  final Method? method;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late final Repository repo = context.read();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String? name = widget.method?.name;
  late ParsedMethod? parsedMethod = widget.method?.placeNotation.map(
    parsePlaceNotation,
  );
  Method? existingMethod;

  void submit(BuildContext context) async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }
    formKey.currentState?.save();
    final name = this.name;
    final parsedMethod = this.parsedMethod;
    if (name != null && parsedMethod != null) {
      try {
        final method = widget.method;
        if (method == null) {
          await repo.createCustomMethod(
            name: name,
            placeNotation: parsedMethod.placeNotation,
            stage: parsedMethod.stage,
          );
        } else {
          await repo.updateCustomMethod(
            method.copyWith(
              name: name,
              placeNotation: parsedMethod.placeNotation,
              stage: parsedMethod.stage,
            ),
          );
          final deck = await repo.getDeck(
            method: method.id,
            isCustomMethod: method.isCustomMethod,
          );
          if (deck != null) await repo.updateDeck(deck.id, name: name);
        }
      } catch (e) {
        if (!context.mounted) return;
        error(context, e.toString());
        return;
      }
    }

    if (context.mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.method != null
                ? 'Edit ${widget.method?.name}'
                : 'New method',
          ),
          actions: [
            IconButton(
              onPressed: () => submit(context),
              icon: Icon(Icons.save),
            ),
          ],
          actionsPadding: .only(right: 8),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => submit(context),
          icon: Icon(Icons.save),
          label: Text('Save'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8).copyWith(bottom: 0),
              child: Form(
                key: formKey,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final children = [
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                        ),
                        initialValue: widget.method?.name,
                        validator: (s) {
                          if (s?.isEmpty ?? true) {
                            return 'Cannot be empty';
                          }
                          return null;
                        },
                        autovalidateMode: .onUserInteraction,
                        onSaved: (s) {
                          name = s;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Place notation',
                          errorText: existingMethod.map(
                            (m) => 'Method already exists: ${m.name}',
                          ),
                        ),
                        initialValue: widget.method?.placeNotation,
                        validator: (s) {
                          if (s?.isEmpty ?? true) {
                            return 'Cannot be empty';
                          }
                          return null;
                        },
                        onChanged: (s) async {
                          parsedMethod = parsePlaceNotation(s);
                          final result = await repo.getMethodByPlaceNotation(s);

                          setState(() {
                            existingMethod = result;
                          });
                        },
                        autovalidateMode: .onUserInteraction,
                        onSaved: (s) {
                          parsedMethod = s.map(parsePlaceNotation);
                        },
                      ),
                    ];
                    if (constraints.maxWidth > 600) {
                      return Row(
                        spacing: 8,
                        children: children
                            .map((x) => Expanded(child: x))
                            .toList(),
                      );
                    } else {
                      return Column(spacing: 8, children: children);
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: MethodDiagram(parsedMethod: parsedMethod ?? .empty()),
            ),
          ],
        ),
      ),
    );
  }
}
