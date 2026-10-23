import 'dart:math' show max;

class ParsedMethod {
  final String placeNotation;
  final List<String> placeNotationChanges;
  final int stage;
  final List<int> rowData;

  ParsedMethod({
    required this.placeNotation,
    required this.placeNotationChanges,
    required this.stage,
    required this.rowData,
  });

  ParsedMethod.empty()
    : placeNotation = '',
      placeNotationChanges = [],
      stage = 0,
      rowData = [];

  Iterable<List<int>> get rows sync* {
    int i = 0;
    final stage = this.stage;
    while (i < rowData.length) {
      yield rowData.sublist(i, i + stage);
      i += stage;
    }
  }

  int get length {
    if (rowData.isEmpty) return 0;
    return (rowData.length ~/ stage) - 1;
  }

  List<int>? get leadEnd => rows.lastOrNull;

  List<int> get huntBells {
    final leadEnd = this.leadEnd;
    return List.generate(
      stage,
      (i) => i,
    ).where((x) => leadEnd?[x] == x).toList();
  }

  List<int> get insideBells {
    final huntBells = this.huntBells;
    return List.generate(
      stage,
      (i) => i,
    ).where((x) => !huntBells.contains(x)).toList();
  }

  Iterable<List<int>> rowsFrom(List<int> start) sync* {
    for (final row in rows.skip(1)) {
      yield row.map((x) => start[x]).toList();
    }
  }

  Iterable<List<int>> get plainCourse sync* {
    List<int> lastRow = List.generate(stage, (i) => i);
    for (final row in rows) {
      yield row;
      lastRow = row;
    }
    while (!isRounds(lastRow)) {
      for (final row in rowsFrom(lastRow)) {
        yield row;
        lastRow = row;
      }
    }
  }
}

bool isRounds(List<int> row) {
  return row.indexed.every((t) => t.$1 == t.$2);
}

int? toBellNumber(int c) {
  switch (c) {
    case > 0x30 && <= 0x39: // 123456789
      return c - 0x30;
    case 0x30: // 0
      return 10;
    case 0x45: // E
      return 11;
    case 0x54: // T
      return 12;
    case >= 0x41 && <= 0x44: // ABCD
      return c - 0x34;
  }
  return null;
}

ParsedMethod parsePlaceNotation(String placeNotation, {int? stage}) {
  List<String> sections = placeNotation.toUpperCase().split(",");
  List<int> units;

  if (sections.length > 1) {
    units = [];
    for (final s in sections) {
      units += s.codeUnits;
      if (s.endsWith("x")) {
        units.addAll(s.codeUnits.reversed.skip(1));
      } else {
        units.addAll(
          s.codeUnits.reversed.skipWhile((x) => toBellNumber(x) != null),
        );
      }
      units.add(0x2E); // .
    }
  } else {
    units = sections.single.codeUnits;
  }

  final int stage_ = stage ?? units.map(toBellNumber).nonNulls.fold(2, max);
  List<int> rows = List.generate(stage_, (i) => i);
  int rowptr = 0;
  int b = 0;

  void nextRow() {
    int i = 0;
    while (i < stage_) {
      if (i < stage_ - 1 && b & 3 << i == 0) {
        rows.add(rows[rowptr + i + 1]);
        rows.add(rows[rowptr + i]);
        i += 2;
      } else {
        rows.add(rows[rowptr + i]);
        i++;
      }
    }

    // print(rows.getRange(rowptr, rowptr + stage));

    rowptr += stage_;
  }

  void flush() {
    if (b == 0) return;
    nextRow();
    b = 0;
  }

  for (final c in units) {
    switch (c) {
      case 0x58 || 0x2D: // x -
        flush();
        nextRow();
      case 0x2E || 0x2C: // . ,
        flush();
      default:
        int? x = toBellNumber(c);
        if (x != null) {
          b = b | 1 << x - 1;
        }
    }
  }

  flush();

  return ParsedMethod(
    placeNotation: placeNotation,
    placeNotationChanges: sections,
    stage: stage_,
    rowData: rows,
  );
}
