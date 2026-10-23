// ignore_for_file: avoid_print

import 'dart:io';

import 'package:drift/native.dart';
import 'package:xml/xml.dart';

import 'package:methods/db/static/database.dart';

String stageName(int stage) {
  return switch (stage) {
    2 => "Two",
    3 => "Singles",
    4 => "Minimus",
    5 => "Doubles",
    6 => "Minor",
    7 => "Triples",
    8 => "Major",
    9 => "Caters",
    10 => "Royal",
    11 => "Cinques",
    12 => "Maximus",
    13 => "Sextuples",
    14 => "Fourteen",
    15 => "Septuples",
    16 => "Sixteen",
    _ => throw ArgumentError.value(stage),
  };
}

String concatWords(String? a, String? b) {
  a = a ?? "";
  b = b ?? "";
  return (a.isNotEmpty && b.isNotEmpty) ? "$a $b" : "$a$b";
}

void main(List<String> args) async {
  final inFile = File(args.isNotEmpty ? args[0] : ".local/CCCBR_methods.xml");
  final document = XmlDocument.parse(inFile.readAsStringSync());

  final db = StaticDatabase(NativeDatabase(File('method_library.sqlite')));

  final double n = 25032;
  var i = 0;

  for (final ms
      in document.getElement("collection")!.findElements("methodSet")) {
    final props = ms.getElement('properties')!;
    final stage = int.parse(props.getElement('stage')!.innerText);
    if (stage > 16) continue;
    // var suffix = stageName(stage);

    // final classification = props.getElement("classification")!;
    // final className = classification.innerText;
    // if (className.isNotEmpty && className != "Hybrid") {
    //   suffix = "$className $suffix";
    // }
    // if (classification.getAttribute("little") == "true" &&
    //     className.isNotEmpty) {
    //   suffix = "Little $suffix";
    // }
    // if (classification.getAttribute("differential") == "true") {
    //   suffix = "Differential $suffix";
    // }

    for (final method in ms.findElements("method")) {
      final idAttr = method.getAttribute("id")!;
      if (idAttr.codeUnitAt(0) != "m".codeUnitAt(0)) {
        print('error id $idAttr');
      }
      final id = int.parse(idAttr.substring(1));

      // final name = method.getElement("name")!.innerText;
      final title = method.getElement("title")!.innerText;
      // if (title != concatWords(name, suffix)) {
      //   print('error $name | $suffix | $title');
      // }

      final placeNotation = method.getElement("notation")!.innerText;

      await db.createEntry(id, title, placeNotation, stage);

      i++;
      if (i % 10 == 0) {
        final w = ((i / n) * 100).round();
        stdout.write('\r${"#" * w}${"-" * (100 - w)}');
      }
    }
  }
  print("");
}
