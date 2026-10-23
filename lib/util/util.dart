import 'dart:ui';

import 'package:flutter/material.dart';

void snackbar(BuildContext ctx, String text) {
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(text)));
}

void error(BuildContext ctx, String text) => snackbar(ctx, text);

Widget list<T>(
  Future<List<T>> future,
  Widget Function(T) f, {
  bool expanded = false,
  Widget Function()? ifEmpty,
}) {
  final fb = FutureBuilder(
    future: future,
    builder: (ctx, snapshot) {
      if (snapshot.hasError) {
        error(ctx, 'Error: ${snapshot.error}');
      }
      if (ifEmpty != null && snapshot.data?.isEmpty == true) {
        return ifEmpty();
      }
      return ListView(
        padding: .all(8),
        children: snapshot.data?.map(f).toList() ?? [],
      );
    },
  );
  return expanded ? Expanded(child: fb) : fb;
}

R Function((A, B)) t2<A, B, R>(R Function(A, B) f) =>
    (t) => f(t.$1, t.$2);

String ordinalString(int i) {
  String suffix = switch (i) {
    1 => 'st',
    2 => 'nd',
    3 => 'rd',
    _ => 'th',
  };
  return '$i$suffix';
}

Future<bool> yesNoDialog(
  BuildContext context,
  String title,
  Widget content, {
  ButtonStyle? yesStyle,
}) async {
  return (await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: content,
            actions: <Widget>[
              OutlinedButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FilledButton(
                style: yesStyle,
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      )) ??
      false;
}

Color colormap(double? v) {
  return HSVColor.fromAHSV(
    1,
    clampDouble((v ?? 0) * 180, 0, 180),
    1,
    1,
  ).toColor();
}

extension DurationExtension on Duration {
  String format({bool bi = false}) {
    if (bi) {
      return isNegative ? '${(-this).format()} ago' : 'in ${format()}';
    } else {
      return switch (inSeconds) {
        < 60 => '$inSeconds sec',
        < 3600 => '$inMinutes min',
        < 3600 * 24 => '$inHours hour${inHours == 1 ? '' : 's'}',
        < 3600 * 24 * 30 => '$inDays day${inDays == 1 ? '' : 's'}',
        < 3600 * 24 * 365 => '${(inDays / 30).toStringAsFixed(1)} months',
        _ => '${(inDays / 365).toStringAsFixed(1)} years',
      };
    }
  }
}

extension OptionExtension<T> on T? {
  R? map<R>(final R Function(T) f) {
    final t = this;
    return t != null ? f(t) : null;
  }
}

extension StringExtension on String {
  String capitalize() {
    return length > 0
        ? "${this[0].toUpperCase()}${substring(1).toLowerCase()}"
        : this;
  }
}

extension ListExtension<A, B> on List<(A, B)> {
  Iterable<R> map2<R>(final R Function(A, B) toElement) => map(t2(toElement));
}

extension BuildContextExtension on BuildContext {
  Future<dynamic> push(Widget Function(BuildContext) builder) =>
      Navigator.of(this).push(MaterialPageRoute(builder: builder));

  void pop<T extends Object?>([T? result]) {
    if (mounted) Navigator.of(this).pop(T);
  }

  TextTheme get textTheme => Theme.of(this).textTheme;
}
