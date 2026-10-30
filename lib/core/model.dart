import 'package:dart_mappable/dart_mappable.dart';
import 'package:fsrs/fsrs.dart' as fsrs;
import 'package:methods/core/method.dart';

part 'model.mapper.dart';

// do not rename members
enum CardType { placeBell }

@MappableClass()
class MethodCard with MethodCardMappable {
  final int id;
  final fsrs.Card card;
  final int method;
  final CardType type;
  final int placeBell;
  final bool paused;
  final bool learned;

  MethodCard({
    required this.id,
    required this.card,
    required this.method,
    required this.type,
    required this.placeBell,
    required this.paused,
    required this.learned,
  });
}

@MappableClass()
class Method with MethodMappable {
  final int id;
  final MethodData data;
  final bool hasDeck;

  Method({required this.id, required this.data, required this.hasDeck});

  ParsedMethod parse() => data.parse();
}

@MappableClass()
class MethodData with MethodDataMappable {
  final String name;
  final String placeNotation;
  final int stage;
  final int? libraryId;

  MethodData({
    required this.name,
    required this.placeNotation,
    required this.stage,
    required this.libraryId,
  });

  ParsedMethod parse() => parsePlaceNotation(placeNotation);
}
