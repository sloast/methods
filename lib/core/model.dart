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
  final int deck;
  final CardType type;
  final int placeBell;
  final bool paused;
  final bool learned;

  MethodCard({
    required this.id,
    required this.card,
    required this.deck,
    required this.type,
    required this.placeBell,
    required this.paused,
    required this.learned,
  });
}

@MappableClass()
class MethodDeck with MethodDeckMappable {
  final int id;
  final String name;
  final int method;
  final bool isCustomMethod;

  MethodDeck({
    required this.id,
    required this.name,
    required this.method,
    required this.isCustomMethod,
  });
}

@MappableClass()
class Method with MethodMappable {
  final int id;
  final String name;
  final String placeNotation;
  final int stage;
  final bool isCustomMethod;

  Method({
    required this.id,
    required this.name,
    required this.placeNotation,
    required this.stage,
    required this.isCustomMethod,
  });

  ParsedMethod parse() => parsePlaceNotation(placeNotation);
}
