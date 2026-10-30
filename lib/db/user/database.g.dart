// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MethodsTable extends Methods with TableInfo<$MethodsTable, Method> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MethodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _placeNotationMeta = const VerificationMeta(
    'placeNotation',
  );
  @override
  late final GeneratedColumn<String> placeNotation = GeneratedColumn<String>(
    'place_notation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stageMeta = const VerificationMeta('stage');
  @override
  late final GeneratedColumn<int> stage = GeneratedColumn<int>(
    'stage',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _libraryIdMeta = const VerificationMeta(
    'libraryId',
  );
  @override
  late final GeneratedColumn<int> libraryId = GeneratedColumn<int>(
    'library_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _hasDeckMeta = const VerificationMeta(
    'hasDeck',
  );
  @override
  late final GeneratedColumn<bool> hasDeck = GeneratedColumn<bool>(
    'has_deck',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_deck" IN (0, 1))',
    ),
  );
  static const VerificationMeta _deckSettingsMeta = const VerificationMeta(
    'deckSettings',
  );
  @override
  late final GeneratedColumn<String> deckSettings = GeneratedColumn<String>(
    'deck_settings',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    placeNotation,
    stage,
    libraryId,
    hasDeck,
    deckSettings,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'methods';
  @override
  VerificationContext validateIntegrity(
    Insertable<Method> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('place_notation')) {
      context.handle(
        _placeNotationMeta,
        placeNotation.isAcceptableOrUnknown(
          data['place_notation']!,
          _placeNotationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_placeNotationMeta);
    }
    if (data.containsKey('stage')) {
      context.handle(
        _stageMeta,
        stage.isAcceptableOrUnknown(data['stage']!, _stageMeta),
      );
    } else if (isInserting) {
      context.missing(_stageMeta);
    }
    if (data.containsKey('library_id')) {
      context.handle(
        _libraryIdMeta,
        libraryId.isAcceptableOrUnknown(data['library_id']!, _libraryIdMeta),
      );
    }
    if (data.containsKey('has_deck')) {
      context.handle(
        _hasDeckMeta,
        hasDeck.isAcceptableOrUnknown(data['has_deck']!, _hasDeckMeta),
      );
    } else if (isInserting) {
      context.missing(_hasDeckMeta);
    }
    if (data.containsKey('deck_settings')) {
      context.handle(
        _deckSettingsMeta,
        deckSettings.isAcceptableOrUnknown(
          data['deck_settings']!,
          _deckSettingsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Method map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Method(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      placeNotation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}place_notation'],
      )!,
      stage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stage'],
      )!,
      libraryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}library_id'],
      ),
      hasDeck: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_deck'],
      )!,
      deckSettings: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deck_settings'],
      ),
    );
  }

  @override
  $MethodsTable createAlias(String alias) {
    return $MethodsTable(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
}

class Method extends DataClass implements Insertable<Method> {
  final int id;
  final String name;
  final String placeNotation;
  final int stage;
  final int? libraryId;
  final bool hasDeck;
  final String? deckSettings;
  const Method({
    required this.id,
    required this.name,
    required this.placeNotation,
    required this.stage,
    this.libraryId,
    required this.hasDeck,
    this.deckSettings,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['place_notation'] = Variable<String>(placeNotation);
    map['stage'] = Variable<int>(stage);
    if (!nullToAbsent || libraryId != null) {
      map['library_id'] = Variable<int>(libraryId);
    }
    map['has_deck'] = Variable<bool>(hasDeck);
    if (!nullToAbsent || deckSettings != null) {
      map['deck_settings'] = Variable<String>(deckSettings);
    }
    return map;
  }

  MethodsCompanion toCompanion(bool nullToAbsent) {
    return MethodsCompanion(
      id: Value(id),
      name: Value(name),
      placeNotation: Value(placeNotation),
      stage: Value(stage),
      libraryId: libraryId == null && nullToAbsent
          ? const Value.absent()
          : Value(libraryId),
      hasDeck: Value(hasDeck),
      deckSettings: deckSettings == null && nullToAbsent
          ? const Value.absent()
          : Value(deckSettings),
    );
  }

  factory Method.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Method(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      placeNotation: serializer.fromJson<String>(json['placeNotation']),
      stage: serializer.fromJson<int>(json['stage']),
      libraryId: serializer.fromJson<int?>(json['libraryId']),
      hasDeck: serializer.fromJson<bool>(json['hasDeck']),
      deckSettings: serializer.fromJson<String?>(json['deckSettings']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'placeNotation': serializer.toJson<String>(placeNotation),
      'stage': serializer.toJson<int>(stage),
      'libraryId': serializer.toJson<int?>(libraryId),
      'hasDeck': serializer.toJson<bool>(hasDeck),
      'deckSettings': serializer.toJson<String?>(deckSettings),
    };
  }

  Method copyWith({
    int? id,
    String? name,
    String? placeNotation,
    int? stage,
    Value<int?> libraryId = const Value.absent(),
    bool? hasDeck,
    Value<String?> deckSettings = const Value.absent(),
  }) => Method(
    id: id ?? this.id,
    name: name ?? this.name,
    placeNotation: placeNotation ?? this.placeNotation,
    stage: stage ?? this.stage,
    libraryId: libraryId.present ? libraryId.value : this.libraryId,
    hasDeck: hasDeck ?? this.hasDeck,
    deckSettings: deckSettings.present ? deckSettings.value : this.deckSettings,
  );
  Method copyWithCompanion(MethodsCompanion data) {
    return Method(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      placeNotation: data.placeNotation.present
          ? data.placeNotation.value
          : this.placeNotation,
      stage: data.stage.present ? data.stage.value : this.stage,
      libraryId: data.libraryId.present ? data.libraryId.value : this.libraryId,
      hasDeck: data.hasDeck.present ? data.hasDeck.value : this.hasDeck,
      deckSettings: data.deckSettings.present
          ? data.deckSettings.value
          : this.deckSettings,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Method(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('placeNotation: $placeNotation, ')
          ..write('stage: $stage, ')
          ..write('libraryId: $libraryId, ')
          ..write('hasDeck: $hasDeck, ')
          ..write('deckSettings: $deckSettings')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    placeNotation,
    stage,
    libraryId,
    hasDeck,
    deckSettings,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Method &&
          other.id == this.id &&
          other.name == this.name &&
          other.placeNotation == this.placeNotation &&
          other.stage == this.stage &&
          other.libraryId == this.libraryId &&
          other.hasDeck == this.hasDeck &&
          other.deckSettings == this.deckSettings);
}

class MethodsCompanion extends UpdateCompanion<Method> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> placeNotation;
  final Value<int> stage;
  final Value<int?> libraryId;
  final Value<bool> hasDeck;
  final Value<String?> deckSettings;
  const MethodsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.placeNotation = const Value.absent(),
    this.stage = const Value.absent(),
    this.libraryId = const Value.absent(),
    this.hasDeck = const Value.absent(),
    this.deckSettings = const Value.absent(),
  });
  MethodsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String placeNotation,
    required int stage,
    this.libraryId = const Value.absent(),
    required bool hasDeck,
    this.deckSettings = const Value.absent(),
  }) : name = Value(name),
       placeNotation = Value(placeNotation),
       stage = Value(stage),
       hasDeck = Value(hasDeck);
  static Insertable<Method> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? placeNotation,
    Expression<int>? stage,
    Expression<int>? libraryId,
    Expression<bool>? hasDeck,
    Expression<String>? deckSettings,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (placeNotation != null) 'place_notation': placeNotation,
      if (stage != null) 'stage': stage,
      if (libraryId != null) 'library_id': libraryId,
      if (hasDeck != null) 'has_deck': hasDeck,
      if (deckSettings != null) 'deck_settings': deckSettings,
    });
  }

  MethodsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? placeNotation,
    Value<int>? stage,
    Value<int?>? libraryId,
    Value<bool>? hasDeck,
    Value<String?>? deckSettings,
  }) {
    return MethodsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      placeNotation: placeNotation ?? this.placeNotation,
      stage: stage ?? this.stage,
      libraryId: libraryId ?? this.libraryId,
      hasDeck: hasDeck ?? this.hasDeck,
      deckSettings: deckSettings ?? this.deckSettings,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (placeNotation.present) {
      map['place_notation'] = Variable<String>(placeNotation.value);
    }
    if (stage.present) {
      map['stage'] = Variable<int>(stage.value);
    }
    if (libraryId.present) {
      map['library_id'] = Variable<int>(libraryId.value);
    }
    if (hasDeck.present) {
      map['has_deck'] = Variable<bool>(hasDeck.value);
    }
    if (deckSettings.present) {
      map['deck_settings'] = Variable<String>(deckSettings.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MethodsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('placeNotation: $placeNotation, ')
          ..write('stage: $stage, ')
          ..write('libraryId: $libraryId, ')
          ..write('hasDeck: $hasDeck, ')
          ..write('deckSettings: $deckSettings')
          ..write(')'))
        .toString();
  }
}

class $CardsTable extends Cards with TableInfo<$CardsTable, Card> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<fsrs.State, int> state =
      GeneratedColumn<int>(
        'state',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<fsrs.State>($CardsTable.$converterstate);
  static const VerificationMeta _stepMeta = const VerificationMeta('step');
  @override
  late final GeneratedColumn<int> step = GeneratedColumn<int>(
    'step',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stabilityMeta = const VerificationMeta(
    'stability',
  );
  @override
  late final GeneratedColumn<double> stability = GeneratedColumn<double>(
    'stability',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<double> difficulty = GeneratedColumn<double>(
    'difficulty',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueMeta = const VerificationMeta('due');
  @override
  late final GeneratedColumn<DateTime> due = GeneratedColumn<DateTime>(
    'due',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastReviewMeta = const VerificationMeta(
    'lastReview',
  );
  @override
  late final GeneratedColumn<DateTime> lastReview = GeneratedColumn<DateTime>(
    'last_review',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<int> method = GeneratedColumn<int>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES methods (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<CardType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<CardType>($CardsTable.$convertertype);
  static const VerificationMeta _placeBellMeta = const VerificationMeta(
    'placeBell',
  );
  @override
  late final GeneratedColumn<int> placeBell = GeneratedColumn<int>(
    'place_bell',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pausedMeta = const VerificationMeta('paused');
  @override
  late final GeneratedColumn<bool> paused = GeneratedColumn<bool>(
    'paused',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("paused" IN (0, 1))',
    ),
  );
  static const VerificationMeta _learnedMeta = const VerificationMeta(
    'learned',
  );
  @override
  late final GeneratedColumn<bool> learned = GeneratedColumn<bool>(
    'learned',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("learned" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    state,
    step,
    stability,
    difficulty,
    due,
    lastReview,
    method,
    type,
    placeBell,
    paused,
    learned,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cards';
  @override
  VerificationContext validateIntegrity(
    Insertable<Card> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('step')) {
      context.handle(
        _stepMeta,
        step.isAcceptableOrUnknown(data['step']!, _stepMeta),
      );
    }
    if (data.containsKey('stability')) {
      context.handle(
        _stabilityMeta,
        stability.isAcceptableOrUnknown(data['stability']!, _stabilityMeta),
      );
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    }
    if (data.containsKey('due')) {
      context.handle(
        _dueMeta,
        due.isAcceptableOrUnknown(data['due']!, _dueMeta),
      );
    } else if (isInserting) {
      context.missing(_dueMeta);
    }
    if (data.containsKey('last_review')) {
      context.handle(
        _lastReviewMeta,
        lastReview.isAcceptableOrUnknown(data['last_review']!, _lastReviewMeta),
      );
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('place_bell')) {
      context.handle(
        _placeBellMeta,
        placeBell.isAcceptableOrUnknown(data['place_bell']!, _placeBellMeta),
      );
    } else if (isInserting) {
      context.missing(_placeBellMeta);
    }
    if (data.containsKey('paused')) {
      context.handle(
        _pausedMeta,
        paused.isAcceptableOrUnknown(data['paused']!, _pausedMeta),
      );
    } else if (isInserting) {
      context.missing(_pausedMeta);
    }
    if (data.containsKey('learned')) {
      context.handle(
        _learnedMeta,
        learned.isAcceptableOrUnknown(data['learned']!, _learnedMeta),
      );
    } else if (isInserting) {
      context.missing(_learnedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {method, type, placeBell},
  ];
  @override
  Card map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Card(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      state: $CardsTable.$converterstate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}state'],
        )!,
      ),
      step: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}step'],
      ),
      stability: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stability'],
      ),
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}difficulty'],
      ),
      due: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due'],
      )!,
      lastReview: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_review'],
      ),
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}method'],
      )!,
      type: $CardsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      placeBell: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}place_bell'],
      )!,
      paused: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}paused'],
      )!,
      learned: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}learned'],
      )!,
    );
  }

  @override
  $CardsTable createAlias(String alias) {
    return $CardsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<fsrs.State, int, int> $converterstate =
      const EnumIndexConverter<fsrs.State>(fsrs.State.values);
  static JsonTypeConverter2<CardType, String, String> $convertertype =
      const EnumNameConverter<CardType>(CardType.values);
  @override
  bool get isStrict => true;
}

class Card extends DataClass implements Insertable<Card> {
  final int id;
  final fsrs.State state;
  final int? step;
  final double? stability;
  final double? difficulty;
  final DateTime due;
  final DateTime? lastReview;
  final int method;
  final CardType type;
  final int placeBell;
  final bool paused;
  final bool learned;
  const Card({
    required this.id,
    required this.state,
    this.step,
    this.stability,
    this.difficulty,
    required this.due,
    this.lastReview,
    required this.method,
    required this.type,
    required this.placeBell,
    required this.paused,
    required this.learned,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['state'] = Variable<int>($CardsTable.$converterstate.toSql(state));
    }
    if (!nullToAbsent || step != null) {
      map['step'] = Variable<int>(step);
    }
    if (!nullToAbsent || stability != null) {
      map['stability'] = Variable<double>(stability);
    }
    if (!nullToAbsent || difficulty != null) {
      map['difficulty'] = Variable<double>(difficulty);
    }
    map['due'] = Variable<DateTime>(due);
    if (!nullToAbsent || lastReview != null) {
      map['last_review'] = Variable<DateTime>(lastReview);
    }
    map['method'] = Variable<int>(method);
    {
      map['type'] = Variable<String>($CardsTable.$convertertype.toSql(type));
    }
    map['place_bell'] = Variable<int>(placeBell);
    map['paused'] = Variable<bool>(paused);
    map['learned'] = Variable<bool>(learned);
    return map;
  }

  CardsCompanion toCompanion(bool nullToAbsent) {
    return CardsCompanion(
      id: Value(id),
      state: Value(state),
      step: step == null && nullToAbsent ? const Value.absent() : Value(step),
      stability: stability == null && nullToAbsent
          ? const Value.absent()
          : Value(stability),
      difficulty: difficulty == null && nullToAbsent
          ? const Value.absent()
          : Value(difficulty),
      due: Value(due),
      lastReview: lastReview == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReview),
      method: Value(method),
      type: Value(type),
      placeBell: Value(placeBell),
      paused: Value(paused),
      learned: Value(learned),
    );
  }

  factory Card.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Card(
      id: serializer.fromJson<int>(json['id']),
      state: $CardsTable.$converterstate.fromJson(
        serializer.fromJson<int>(json['state']),
      ),
      step: serializer.fromJson<int?>(json['step']),
      stability: serializer.fromJson<double?>(json['stability']),
      difficulty: serializer.fromJson<double?>(json['difficulty']),
      due: serializer.fromJson<DateTime>(json['due']),
      lastReview: serializer.fromJson<DateTime?>(json['lastReview']),
      method: serializer.fromJson<int>(json['method']),
      type: $CardsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      placeBell: serializer.fromJson<int>(json['placeBell']),
      paused: serializer.fromJson<bool>(json['paused']),
      learned: serializer.fromJson<bool>(json['learned']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'state': serializer.toJson<int>(
        $CardsTable.$converterstate.toJson(state),
      ),
      'step': serializer.toJson<int?>(step),
      'stability': serializer.toJson<double?>(stability),
      'difficulty': serializer.toJson<double?>(difficulty),
      'due': serializer.toJson<DateTime>(due),
      'lastReview': serializer.toJson<DateTime?>(lastReview),
      'method': serializer.toJson<int>(method),
      'type': serializer.toJson<String>(
        $CardsTable.$convertertype.toJson(type),
      ),
      'placeBell': serializer.toJson<int>(placeBell),
      'paused': serializer.toJson<bool>(paused),
      'learned': serializer.toJson<bool>(learned),
    };
  }

  Card copyWith({
    int? id,
    fsrs.State? state,
    Value<int?> step = const Value.absent(),
    Value<double?> stability = const Value.absent(),
    Value<double?> difficulty = const Value.absent(),
    DateTime? due,
    Value<DateTime?> lastReview = const Value.absent(),
    int? method,
    CardType? type,
    int? placeBell,
    bool? paused,
    bool? learned,
  }) => Card(
    id: id ?? this.id,
    state: state ?? this.state,
    step: step.present ? step.value : this.step,
    stability: stability.present ? stability.value : this.stability,
    difficulty: difficulty.present ? difficulty.value : this.difficulty,
    due: due ?? this.due,
    lastReview: lastReview.present ? lastReview.value : this.lastReview,
    method: method ?? this.method,
    type: type ?? this.type,
    placeBell: placeBell ?? this.placeBell,
    paused: paused ?? this.paused,
    learned: learned ?? this.learned,
  );
  Card copyWithCompanion(CardsCompanion data) {
    return Card(
      id: data.id.present ? data.id.value : this.id,
      state: data.state.present ? data.state.value : this.state,
      step: data.step.present ? data.step.value : this.step,
      stability: data.stability.present ? data.stability.value : this.stability,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      due: data.due.present ? data.due.value : this.due,
      lastReview: data.lastReview.present
          ? data.lastReview.value
          : this.lastReview,
      method: data.method.present ? data.method.value : this.method,
      type: data.type.present ? data.type.value : this.type,
      placeBell: data.placeBell.present ? data.placeBell.value : this.placeBell,
      paused: data.paused.present ? data.paused.value : this.paused,
      learned: data.learned.present ? data.learned.value : this.learned,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Card(')
          ..write('id: $id, ')
          ..write('state: $state, ')
          ..write('step: $step, ')
          ..write('stability: $stability, ')
          ..write('difficulty: $difficulty, ')
          ..write('due: $due, ')
          ..write('lastReview: $lastReview, ')
          ..write('method: $method, ')
          ..write('type: $type, ')
          ..write('placeBell: $placeBell, ')
          ..write('paused: $paused, ')
          ..write('learned: $learned')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    state,
    step,
    stability,
    difficulty,
    due,
    lastReview,
    method,
    type,
    placeBell,
    paused,
    learned,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Card &&
          other.id == this.id &&
          other.state == this.state &&
          other.step == this.step &&
          other.stability == this.stability &&
          other.difficulty == this.difficulty &&
          other.due == this.due &&
          other.lastReview == this.lastReview &&
          other.method == this.method &&
          other.type == this.type &&
          other.placeBell == this.placeBell &&
          other.paused == this.paused &&
          other.learned == this.learned);
}

class CardsCompanion extends UpdateCompanion<Card> {
  final Value<int> id;
  final Value<fsrs.State> state;
  final Value<int?> step;
  final Value<double?> stability;
  final Value<double?> difficulty;
  final Value<DateTime> due;
  final Value<DateTime?> lastReview;
  final Value<int> method;
  final Value<CardType> type;
  final Value<int> placeBell;
  final Value<bool> paused;
  final Value<bool> learned;
  const CardsCompanion({
    this.id = const Value.absent(),
    this.state = const Value.absent(),
    this.step = const Value.absent(),
    this.stability = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.due = const Value.absent(),
    this.lastReview = const Value.absent(),
    this.method = const Value.absent(),
    this.type = const Value.absent(),
    this.placeBell = const Value.absent(),
    this.paused = const Value.absent(),
    this.learned = const Value.absent(),
  });
  CardsCompanion.insert({
    this.id = const Value.absent(),
    required fsrs.State state,
    this.step = const Value.absent(),
    this.stability = const Value.absent(),
    this.difficulty = const Value.absent(),
    required DateTime due,
    this.lastReview = const Value.absent(),
    required int method,
    required CardType type,
    required int placeBell,
    required bool paused,
    required bool learned,
  }) : state = Value(state),
       due = Value(due),
       method = Value(method),
       type = Value(type),
       placeBell = Value(placeBell),
       paused = Value(paused),
       learned = Value(learned);
  static Insertable<Card> custom({
    Expression<int>? id,
    Expression<int>? state,
    Expression<int>? step,
    Expression<double>? stability,
    Expression<double>? difficulty,
    Expression<DateTime>? due,
    Expression<DateTime>? lastReview,
    Expression<int>? method,
    Expression<String>? type,
    Expression<int>? placeBell,
    Expression<bool>? paused,
    Expression<bool>? learned,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (state != null) 'state': state,
      if (step != null) 'step': step,
      if (stability != null) 'stability': stability,
      if (difficulty != null) 'difficulty': difficulty,
      if (due != null) 'due': due,
      if (lastReview != null) 'last_review': lastReview,
      if (method != null) 'method': method,
      if (type != null) 'type': type,
      if (placeBell != null) 'place_bell': placeBell,
      if (paused != null) 'paused': paused,
      if (learned != null) 'learned': learned,
    });
  }

  CardsCompanion copyWith({
    Value<int>? id,
    Value<fsrs.State>? state,
    Value<int?>? step,
    Value<double?>? stability,
    Value<double?>? difficulty,
    Value<DateTime>? due,
    Value<DateTime?>? lastReview,
    Value<int>? method,
    Value<CardType>? type,
    Value<int>? placeBell,
    Value<bool>? paused,
    Value<bool>? learned,
  }) {
    return CardsCompanion(
      id: id ?? this.id,
      state: state ?? this.state,
      step: step ?? this.step,
      stability: stability ?? this.stability,
      difficulty: difficulty ?? this.difficulty,
      due: due ?? this.due,
      lastReview: lastReview ?? this.lastReview,
      method: method ?? this.method,
      type: type ?? this.type,
      placeBell: placeBell ?? this.placeBell,
      paused: paused ?? this.paused,
      learned: learned ?? this.learned,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (state.present) {
      map['state'] = Variable<int>(
        $CardsTable.$converterstate.toSql(state.value),
      );
    }
    if (step.present) {
      map['step'] = Variable<int>(step.value);
    }
    if (stability.present) {
      map['stability'] = Variable<double>(stability.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<double>(difficulty.value);
    }
    if (due.present) {
      map['due'] = Variable<DateTime>(due.value);
    }
    if (lastReview.present) {
      map['last_review'] = Variable<DateTime>(lastReview.value);
    }
    if (method.present) {
      map['method'] = Variable<int>(method.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $CardsTable.$convertertype.toSql(type.value),
      );
    }
    if (placeBell.present) {
      map['place_bell'] = Variable<int>(placeBell.value);
    }
    if (paused.present) {
      map['paused'] = Variable<bool>(paused.value);
    }
    if (learned.present) {
      map['learned'] = Variable<bool>(learned.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardsCompanion(')
          ..write('id: $id, ')
          ..write('state: $state, ')
          ..write('step: $step, ')
          ..write('stability: $stability, ')
          ..write('difficulty: $difficulty, ')
          ..write('due: $due, ')
          ..write('lastReview: $lastReview, ')
          ..write('method: $method, ')
          ..write('type: $type, ')
          ..write('placeBell: $placeBell, ')
          ..write('paused: $paused, ')
          ..write('learned: $learned')
          ..write(')'))
        .toString();
  }
}

class $ReviewLogsTable extends ReviewLogs
    with TableInfo<$ReviewLogsTable, ReviewLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _cardMeta = const VerificationMeta('card');
  @override
  late final GeneratedColumn<int> card = GeneratedColumn<int>(
    'card',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cards (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<fsrs.Rating, int> rating =
      GeneratedColumn<int>(
        'rating',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<fsrs.Rating>($ReviewLogsTable.$converterrating);
  static const VerificationMeta _reviewDateTimeMeta = const VerificationMeta(
    'reviewDateTime',
  );
  @override
  late final GeneratedColumn<DateTime> reviewDateTime =
      GeneratedColumn<DateTime>(
        'review_date_time',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _reviewDurationMeta = const VerificationMeta(
    'reviewDuration',
  );
  @override
  late final GeneratedColumn<int> reviewDuration = GeneratedColumn<int>(
    'review_duration',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    card,
    rating,
    reviewDateTime,
    reviewDuration,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReviewLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('card')) {
      context.handle(
        _cardMeta,
        card.isAcceptableOrUnknown(data['card']!, _cardMeta),
      );
    } else if (isInserting) {
      context.missing(_cardMeta);
    }
    if (data.containsKey('review_date_time')) {
      context.handle(
        _reviewDateTimeMeta,
        reviewDateTime.isAcceptableOrUnknown(
          data['review_date_time']!,
          _reviewDateTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reviewDateTimeMeta);
    }
    if (data.containsKey('review_duration')) {
      context.handle(
        _reviewDurationMeta,
        reviewDuration.isAcceptableOrUnknown(
          data['review_duration']!,
          _reviewDurationMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      card: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}card'],
      )!,
      rating: $ReviewLogsTable.$converterrating.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}rating'],
        )!,
      ),
      reviewDateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}review_date_time'],
      )!,
      reviewDuration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}review_duration'],
      ),
    );
  }

  @override
  $ReviewLogsTable createAlias(String alias) {
    return $ReviewLogsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<fsrs.Rating, int, int> $converterrating =
      const EnumIndexConverter<fsrs.Rating>(fsrs.Rating.values);
}

class ReviewLog extends DataClass implements Insertable<ReviewLog> {
  final int id;
  final int card;
  final fsrs.Rating rating;
  final DateTime reviewDateTime;
  final int? reviewDuration;
  const ReviewLog({
    required this.id,
    required this.card,
    required this.rating,
    required this.reviewDateTime,
    this.reviewDuration,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['card'] = Variable<int>(card);
    {
      map['rating'] = Variable<int>(
        $ReviewLogsTable.$converterrating.toSql(rating),
      );
    }
    map['review_date_time'] = Variable<DateTime>(reviewDateTime);
    if (!nullToAbsent || reviewDuration != null) {
      map['review_duration'] = Variable<int>(reviewDuration);
    }
    return map;
  }

  ReviewLogsCompanion toCompanion(bool nullToAbsent) {
    return ReviewLogsCompanion(
      id: Value(id),
      card: Value(card),
      rating: Value(rating),
      reviewDateTime: Value(reviewDateTime),
      reviewDuration: reviewDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(reviewDuration),
    );
  }

  factory ReviewLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewLog(
      id: serializer.fromJson<int>(json['id']),
      card: serializer.fromJson<int>(json['card']),
      rating: $ReviewLogsTable.$converterrating.fromJson(
        serializer.fromJson<int>(json['rating']),
      ),
      reviewDateTime: serializer.fromJson<DateTime>(json['reviewDateTime']),
      reviewDuration: serializer.fromJson<int?>(json['reviewDuration']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'card': serializer.toJson<int>(card),
      'rating': serializer.toJson<int>(
        $ReviewLogsTable.$converterrating.toJson(rating),
      ),
      'reviewDateTime': serializer.toJson<DateTime>(reviewDateTime),
      'reviewDuration': serializer.toJson<int?>(reviewDuration),
    };
  }

  ReviewLog copyWith({
    int? id,
    int? card,
    fsrs.Rating? rating,
    DateTime? reviewDateTime,
    Value<int?> reviewDuration = const Value.absent(),
  }) => ReviewLog(
    id: id ?? this.id,
    card: card ?? this.card,
    rating: rating ?? this.rating,
    reviewDateTime: reviewDateTime ?? this.reviewDateTime,
    reviewDuration: reviewDuration.present
        ? reviewDuration.value
        : this.reviewDuration,
  );
  ReviewLog copyWithCompanion(ReviewLogsCompanion data) {
    return ReviewLog(
      id: data.id.present ? data.id.value : this.id,
      card: data.card.present ? data.card.value : this.card,
      rating: data.rating.present ? data.rating.value : this.rating,
      reviewDateTime: data.reviewDateTime.present
          ? data.reviewDateTime.value
          : this.reviewDateTime,
      reviewDuration: data.reviewDuration.present
          ? data.reviewDuration.value
          : this.reviewDuration,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewLog(')
          ..write('id: $id, ')
          ..write('card: $card, ')
          ..write('rating: $rating, ')
          ..write('reviewDateTime: $reviewDateTime, ')
          ..write('reviewDuration: $reviewDuration')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, card, rating, reviewDateTime, reviewDuration);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewLog &&
          other.id == this.id &&
          other.card == this.card &&
          other.rating == this.rating &&
          other.reviewDateTime == this.reviewDateTime &&
          other.reviewDuration == this.reviewDuration);
}

class ReviewLogsCompanion extends UpdateCompanion<ReviewLog> {
  final Value<int> id;
  final Value<int> card;
  final Value<fsrs.Rating> rating;
  final Value<DateTime> reviewDateTime;
  final Value<int?> reviewDuration;
  const ReviewLogsCompanion({
    this.id = const Value.absent(),
    this.card = const Value.absent(),
    this.rating = const Value.absent(),
    this.reviewDateTime = const Value.absent(),
    this.reviewDuration = const Value.absent(),
  });
  ReviewLogsCompanion.insert({
    this.id = const Value.absent(),
    required int card,
    required fsrs.Rating rating,
    required DateTime reviewDateTime,
    this.reviewDuration = const Value.absent(),
  }) : card = Value(card),
       rating = Value(rating),
       reviewDateTime = Value(reviewDateTime);
  static Insertable<ReviewLog> custom({
    Expression<int>? id,
    Expression<int>? card,
    Expression<int>? rating,
    Expression<DateTime>? reviewDateTime,
    Expression<int>? reviewDuration,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (card != null) 'card': card,
      if (rating != null) 'rating': rating,
      if (reviewDateTime != null) 'review_date_time': reviewDateTime,
      if (reviewDuration != null) 'review_duration': reviewDuration,
    });
  }

  ReviewLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? card,
    Value<fsrs.Rating>? rating,
    Value<DateTime>? reviewDateTime,
    Value<int?>? reviewDuration,
  }) {
    return ReviewLogsCompanion(
      id: id ?? this.id,
      card: card ?? this.card,
      rating: rating ?? this.rating,
      reviewDateTime: reviewDateTime ?? this.reviewDateTime,
      reviewDuration: reviewDuration ?? this.reviewDuration,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (card.present) {
      map['card'] = Variable<int>(card.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(
        $ReviewLogsTable.$converterrating.toSql(rating.value),
      );
    }
    if (reviewDateTime.present) {
      map['review_date_time'] = Variable<DateTime>(reviewDateTime.value);
    }
    if (reviewDuration.present) {
      map['review_duration'] = Variable<int>(reviewDuration.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewLogsCompanion(')
          ..write('id: $id, ')
          ..write('card: $card, ')
          ..write('rating: $rating, ')
          ..write('reviewDateTime: $reviewDateTime, ')
          ..write('reviewDuration: $reviewDuration')
          ..write(')'))
        .toString();
  }
}

abstract class _$UserDatabase extends GeneratedDatabase {
  _$UserDatabase(QueryExecutor e) : super(e);
  $UserDatabaseManager get managers => $UserDatabaseManager(this);
  late final $MethodsTable methods = $MethodsTable(this);
  late final $CardsTable cards = $CardsTable(this);
  late final $ReviewLogsTable reviewLogs = $ReviewLogsTable(this);
  late final Index cardDue = Index(
    'cardDue',
    'CREATE INDEX cardDue ON cards (due)',
  );
  late final Index cardMethod = Index(
    'cardMethod',
    'CREATE INDEX cardMethod ON cards (method)',
  );
  late final Index methodName = Index(
    'methodName',
    'CREATE INDEX methodName ON methods (name)',
  );
  late final Index methodPlaceNotation = Index(
    'methodPlaceNotation',
    'CREATE INDEX methodPlaceNotation ON methods (place_notation)',
  );
  late final Index reviewLogCard = Index(
    'reviewLogCard',
    'CREATE INDEX reviewLogCard ON review_logs (card)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    methods,
    cards,
    reviewLogs,
    cardDue,
    cardMethod,
    methodName,
    methodPlaceNotation,
    reviewLogCard,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'methods',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('cards', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cards',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('review_logs', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$MethodsTableCreateCompanionBuilder =
    MethodsCompanion Function({
      Value<int> id,
      required String name,
      required String placeNotation,
      required int stage,
      Value<int?> libraryId,
      required bool hasDeck,
      Value<String?> deckSettings,
    });
typedef $$MethodsTableUpdateCompanionBuilder =
    MethodsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> placeNotation,
      Value<int> stage,
      Value<int?> libraryId,
      Value<bool> hasDeck,
      Value<String?> deckSettings,
    });

final class $$MethodsTableReferences
    extends BaseReferences<_$UserDatabase, $MethodsTable, Method> {
  $$MethodsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CardsTable, List<Card>> _cardsRefsTable(
    _$UserDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.cards,
    aliasName: 'methods__id__cards__method',
  );

  $$CardsTableProcessedTableManager get cardsRefs {
    final manager = $$CardsTableTableManager(
      $_db,
      $_db.cards,
    ).filter((f) => f.method.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_cardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MethodsTableFilterComposer
    extends Composer<_$UserDatabase, $MethodsTable> {
  $$MethodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get placeNotation => $composableBuilder(
    column: $table.placeNotation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasDeck => $composableBuilder(
    column: $table.hasDeck,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deckSettings => $composableBuilder(
    column: $table.deckSettings,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> cardsRefs(
    Expression<bool> Function($$CardsTableFilterComposer f) f,
  ) {
    final $$CardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.method,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableFilterComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MethodsTableOrderingComposer
    extends Composer<_$UserDatabase, $MethodsTable> {
  $$MethodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get placeNotation => $composableBuilder(
    column: $table.placeNotation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasDeck => $composableBuilder(
    column: $table.hasDeck,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deckSettings => $composableBuilder(
    column: $table.deckSettings,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MethodsTableAnnotationComposer
    extends Composer<_$UserDatabase, $MethodsTable> {
  $$MethodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get placeNotation => $composableBuilder(
    column: $table.placeNotation,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stage =>
      $composableBuilder(column: $table.stage, builder: (column) => column);

  GeneratedColumn<int> get libraryId =>
      $composableBuilder(column: $table.libraryId, builder: (column) => column);

  GeneratedColumn<bool> get hasDeck =>
      $composableBuilder(column: $table.hasDeck, builder: (column) => column);

  GeneratedColumn<String> get deckSettings => $composableBuilder(
    column: $table.deckSettings,
    builder: (column) => column,
  );

  Expression<T> cardsRefs<T extends Object>(
    Expression<T> Function($$CardsTableAnnotationComposer a) f,
  ) {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.method,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableAnnotationComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MethodsTableTableManager
    extends
        RootTableManager<
          _$UserDatabase,
          $MethodsTable,
          Method,
          $$MethodsTableFilterComposer,
          $$MethodsTableOrderingComposer,
          $$MethodsTableAnnotationComposer,
          $$MethodsTableCreateCompanionBuilder,
          $$MethodsTableUpdateCompanionBuilder,
          (Method, $$MethodsTableReferences),
          Method,
          PrefetchHooks Function({bool cardsRefs})
        > {
  $$MethodsTableTableManager(_$UserDatabase db, $MethodsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MethodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MethodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MethodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> placeNotation = const Value.absent(),
                Value<int> stage = const Value.absent(),
                Value<int?> libraryId = const Value.absent(),
                Value<bool> hasDeck = const Value.absent(),
                Value<String?> deckSettings = const Value.absent(),
              }) => MethodsCompanion(
                id: id,
                name: name,
                placeNotation: placeNotation,
                stage: stage,
                libraryId: libraryId,
                hasDeck: hasDeck,
                deckSettings: deckSettings,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String placeNotation,
                required int stage,
                Value<int?> libraryId = const Value.absent(),
                required bool hasDeck,
                Value<String?> deckSettings = const Value.absent(),
              }) => MethodsCompanion.insert(
                id: id,
                name: name,
                placeNotation: placeNotation,
                stage: stage,
                libraryId: libraryId,
                hasDeck: hasDeck,
                deckSettings: deckSettings,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MethodsTable, Method>(table),
                  $$MethodsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cardsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (cardsRefs) db.cards],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (cardsRefs)
                    await $_getPrefetchedData<Method, $MethodsTable, Card>(
                      currentTable: table,
                      referencedTable: $$MethodsTableReferences._cardsRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$MethodsTableReferences(db, table, p0).cardsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.method == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MethodsTableProcessedTableManager =
    ProcessedTableManager<
      _$UserDatabase,
      $MethodsTable,
      Method,
      $$MethodsTableFilterComposer,
      $$MethodsTableOrderingComposer,
      $$MethodsTableAnnotationComposer,
      $$MethodsTableCreateCompanionBuilder,
      $$MethodsTableUpdateCompanionBuilder,
      (Method, $$MethodsTableReferences),
      Method,
      PrefetchHooks Function({bool cardsRefs})
    >;
typedef $$CardsTableCreateCompanionBuilder =
    CardsCompanion Function({
      Value<int> id,
      required fsrs.State state,
      Value<int?> step,
      Value<double?> stability,
      Value<double?> difficulty,
      required DateTime due,
      Value<DateTime?> lastReview,
      required int method,
      required CardType type,
      required int placeBell,
      required bool paused,
      required bool learned,
    });
typedef $$CardsTableUpdateCompanionBuilder =
    CardsCompanion Function({
      Value<int> id,
      Value<fsrs.State> state,
      Value<int?> step,
      Value<double?> stability,
      Value<double?> difficulty,
      Value<DateTime> due,
      Value<DateTime?> lastReview,
      Value<int> method,
      Value<CardType> type,
      Value<int> placeBell,
      Value<bool> paused,
      Value<bool> learned,
    });

final class $$CardsTableReferences
    extends BaseReferences<_$UserDatabase, $CardsTable, Card> {
  $$CardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MethodsTable _methodTable(_$UserDatabase db) =>
      db.methods.createAlias('cards__method__methods__id');

  $$MethodsTableProcessedTableManager get method {
    final $_column = $_itemColumn<int>('method')!;

    final manager = $$MethodsTableTableManager(
      $_db,
      $_db.methods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_methodTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ReviewLogsTable, List<ReviewLog>>
  _reviewLogsRefsTable(_$UserDatabase db) => MultiTypedResultKey.fromTable(
    db.reviewLogs,
    aliasName: 'cards__id__review_logs__card',
  );

  $$ReviewLogsTableProcessedTableManager get reviewLogsRefs {
    final manager = $$ReviewLogsTableTableManager(
      $_db,
      $_db.reviewLogs,
    ).filter((f) => f.card.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_reviewLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CardsTableFilterComposer extends Composer<_$UserDatabase, $CardsTable> {
  $$CardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<fsrs.State, fsrs.State, int> get state =>
      $composableBuilder(
        column: $table.state,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get step => $composableBuilder(
    column: $table.step,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stability => $composableBuilder(
    column: $table.stability,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get due => $composableBuilder(
    column: $table.due,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastReview => $composableBuilder(
    column: $table.lastReview,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CardType, CardType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get placeBell => $composableBuilder(
    column: $table.placeBell,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get paused => $composableBuilder(
    column: $table.paused,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get learned => $composableBuilder(
    column: $table.learned,
    builder: (column) => ColumnFilters(column),
  );

  $$MethodsTableFilterComposer get method {
    final $$MethodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.method,
      referencedTable: $db.methods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MethodsTableFilterComposer(
            $db: $db,
            $table: $db.methods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> reviewLogsRefs(
    Expression<bool> Function($$ReviewLogsTableFilterComposer f) f,
  ) {
    final $$ReviewLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewLogs,
      getReferencedColumn: (t) => t.card,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewLogsTableFilterComposer(
            $db: $db,
            $table: $db.reviewLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CardsTableOrderingComposer
    extends Composer<_$UserDatabase, $CardsTable> {
  $$CardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get step => $composableBuilder(
    column: $table.step,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stability => $composableBuilder(
    column: $table.stability,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get due => $composableBuilder(
    column: $table.due,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastReview => $composableBuilder(
    column: $table.lastReview,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get placeBell => $composableBuilder(
    column: $table.placeBell,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get paused => $composableBuilder(
    column: $table.paused,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get learned => $composableBuilder(
    column: $table.learned,
    builder: (column) => ColumnOrderings(column),
  );

  $$MethodsTableOrderingComposer get method {
    final $$MethodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.method,
      referencedTable: $db.methods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MethodsTableOrderingComposer(
            $db: $db,
            $table: $db.methods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CardsTableAnnotationComposer
    extends Composer<_$UserDatabase, $CardsTable> {
  $$CardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<fsrs.State, int> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<int> get step =>
      $composableBuilder(column: $table.step, builder: (column) => column);

  GeneratedColumn<double> get stability =>
      $composableBuilder(column: $table.stability, builder: (column) => column);

  GeneratedColumn<double> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get due =>
      $composableBuilder(column: $table.due, builder: (column) => column);

  GeneratedColumn<DateTime> get lastReview => $composableBuilder(
    column: $table.lastReview,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<CardType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get placeBell =>
      $composableBuilder(column: $table.placeBell, builder: (column) => column);

  GeneratedColumn<bool> get paused =>
      $composableBuilder(column: $table.paused, builder: (column) => column);

  GeneratedColumn<bool> get learned =>
      $composableBuilder(column: $table.learned, builder: (column) => column);

  $$MethodsTableAnnotationComposer get method {
    final $$MethodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.method,
      referencedTable: $db.methods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MethodsTableAnnotationComposer(
            $db: $db,
            $table: $db.methods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> reviewLogsRefs<T extends Object>(
    Expression<T> Function($$ReviewLogsTableAnnotationComposer a) f,
  ) {
    final $$ReviewLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewLogs,
      getReferencedColumn: (t) => t.card,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.reviewLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CardsTableTableManager
    extends
        RootTableManager<
          _$UserDatabase,
          $CardsTable,
          Card,
          $$CardsTableFilterComposer,
          $$CardsTableOrderingComposer,
          $$CardsTableAnnotationComposer,
          $$CardsTableCreateCompanionBuilder,
          $$CardsTableUpdateCompanionBuilder,
          (Card, $$CardsTableReferences),
          Card,
          PrefetchHooks Function({bool method, bool reviewLogsRefs})
        > {
  $$CardsTableTableManager(_$UserDatabase db, $CardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<fsrs.State> state = const Value.absent(),
                Value<int?> step = const Value.absent(),
                Value<double?> stability = const Value.absent(),
                Value<double?> difficulty = const Value.absent(),
                Value<DateTime> due = const Value.absent(),
                Value<DateTime?> lastReview = const Value.absent(),
                Value<int> method = const Value.absent(),
                Value<CardType> type = const Value.absent(),
                Value<int> placeBell = const Value.absent(),
                Value<bool> paused = const Value.absent(),
                Value<bool> learned = const Value.absent(),
              }) => CardsCompanion(
                id: id,
                state: state,
                step: step,
                stability: stability,
                difficulty: difficulty,
                due: due,
                lastReview: lastReview,
                method: method,
                type: type,
                placeBell: placeBell,
                paused: paused,
                learned: learned,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required fsrs.State state,
                Value<int?> step = const Value.absent(),
                Value<double?> stability = const Value.absent(),
                Value<double?> difficulty = const Value.absent(),
                required DateTime due,
                Value<DateTime?> lastReview = const Value.absent(),
                required int method,
                required CardType type,
                required int placeBell,
                required bool paused,
                required bool learned,
              }) => CardsCompanion.insert(
                id: id,
                state: state,
                step: step,
                stability: stability,
                difficulty: difficulty,
                due: due,
                lastReview: lastReview,
                method: method,
                type: type,
                placeBell: placeBell,
                paused: paused,
                learned: learned,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CardsTable, Card>(table),
                  $$CardsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({method = false, reviewLogsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (reviewLogsRefs) db.reviewLogs],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (method) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.method,
                                referencedTable: $$CardsTableReferences
                                    ._methodTable(db),
                                referencedColumn: $$CardsTableReferences
                                    ._methodTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (reviewLogsRefs)
                    await $_getPrefetchedData<Card, $CardsTable, ReviewLog>(
                      currentTable: table,
                      referencedTable: $$CardsTableReferences
                          ._reviewLogsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CardsTableReferences(db, table, p0).reviewLogsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.card == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CardsTableProcessedTableManager =
    ProcessedTableManager<
      _$UserDatabase,
      $CardsTable,
      Card,
      $$CardsTableFilterComposer,
      $$CardsTableOrderingComposer,
      $$CardsTableAnnotationComposer,
      $$CardsTableCreateCompanionBuilder,
      $$CardsTableUpdateCompanionBuilder,
      (Card, $$CardsTableReferences),
      Card,
      PrefetchHooks Function({bool method, bool reviewLogsRefs})
    >;
typedef $$ReviewLogsTableCreateCompanionBuilder =
    ReviewLogsCompanion Function({
      Value<int> id,
      required int card,
      required fsrs.Rating rating,
      required DateTime reviewDateTime,
      Value<int?> reviewDuration,
    });
typedef $$ReviewLogsTableUpdateCompanionBuilder =
    ReviewLogsCompanion Function({
      Value<int> id,
      Value<int> card,
      Value<fsrs.Rating> rating,
      Value<DateTime> reviewDateTime,
      Value<int?> reviewDuration,
    });

final class $$ReviewLogsTableReferences
    extends BaseReferences<_$UserDatabase, $ReviewLogsTable, ReviewLog> {
  $$ReviewLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CardsTable _cardTable(_$UserDatabase db) =>
      db.cards.createAlias('review_logs__card__cards__id');

  $$CardsTableProcessedTableManager get card {
    final $_column = $_itemColumn<int>('card')!;

    final manager = $$CardsTableTableManager(
      $_db,
      $_db.cards,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReviewLogsTableFilterComposer
    extends Composer<_$UserDatabase, $ReviewLogsTable> {
  $$ReviewLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<fsrs.Rating, fsrs.Rating, int> get rating =>
      $composableBuilder(
        column: $table.rating,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get reviewDateTime => $composableBuilder(
    column: $table.reviewDateTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewDuration => $composableBuilder(
    column: $table.reviewDuration,
    builder: (column) => ColumnFilters(column),
  );

  $$CardsTableFilterComposer get card {
    final $$CardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.card,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableFilterComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewLogsTableOrderingComposer
    extends Composer<_$UserDatabase, $ReviewLogsTable> {
  $$ReviewLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reviewDateTime => $composableBuilder(
    column: $table.reviewDateTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewDuration => $composableBuilder(
    column: $table.reviewDuration,
    builder: (column) => ColumnOrderings(column),
  );

  $$CardsTableOrderingComposer get card {
    final $$CardsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.card,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableOrderingComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewLogsTableAnnotationComposer
    extends Composer<_$UserDatabase, $ReviewLogsTable> {
  $$ReviewLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<fsrs.Rating, int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<DateTime> get reviewDateTime => $composableBuilder(
    column: $table.reviewDateTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reviewDuration => $composableBuilder(
    column: $table.reviewDuration,
    builder: (column) => column,
  );

  $$CardsTableAnnotationComposer get card {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.card,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableAnnotationComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewLogsTableTableManager
    extends
        RootTableManager<
          _$UserDatabase,
          $ReviewLogsTable,
          ReviewLog,
          $$ReviewLogsTableFilterComposer,
          $$ReviewLogsTableOrderingComposer,
          $$ReviewLogsTableAnnotationComposer,
          $$ReviewLogsTableCreateCompanionBuilder,
          $$ReviewLogsTableUpdateCompanionBuilder,
          (ReviewLog, $$ReviewLogsTableReferences),
          ReviewLog,
          PrefetchHooks Function({bool card})
        > {
  $$ReviewLogsTableTableManager(_$UserDatabase db, $ReviewLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> card = const Value.absent(),
                Value<fsrs.Rating> rating = const Value.absent(),
                Value<DateTime> reviewDateTime = const Value.absent(),
                Value<int?> reviewDuration = const Value.absent(),
              }) => ReviewLogsCompanion(
                id: id,
                card: card,
                rating: rating,
                reviewDateTime: reviewDateTime,
                reviewDuration: reviewDuration,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int card,
                required fsrs.Rating rating,
                required DateTime reviewDateTime,
                Value<int?> reviewDuration = const Value.absent(),
              }) => ReviewLogsCompanion.insert(
                id: id,
                card: card,
                rating: rating,
                reviewDateTime: reviewDateTime,
                reviewDuration: reviewDuration,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReviewLogsTable, ReviewLog>(table),
                  $$ReviewLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({card = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (card) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.card,
                                referencedTable: $$ReviewLogsTableReferences
                                    ._cardTable(db),
                                referencedColumn: $$ReviewLogsTableReferences
                                    ._cardTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReviewLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$UserDatabase,
      $ReviewLogsTable,
      ReviewLog,
      $$ReviewLogsTableFilterComposer,
      $$ReviewLogsTableOrderingComposer,
      $$ReviewLogsTableAnnotationComposer,
      $$ReviewLogsTableCreateCompanionBuilder,
      $$ReviewLogsTableUpdateCompanionBuilder,
      (ReviewLog, $$ReviewLogsTableReferences),
      ReviewLog,
      PrefetchHooks Function({bool card})
    >;

class $UserDatabaseManager {
  final _$UserDatabase _db;
  $UserDatabaseManager(this._db);
  $$MethodsTableTableManager get methods =>
      $$MethodsTableTableManager(_db, _db.methods);
  $$CardsTableTableManager get cards =>
      $$CardsTableTableManager(_db, _db.cards);
  $$ReviewLogsTableTableManager get reviewLogs =>
      $$ReviewLogsTableTableManager(_db, _db.reviewLogs);
}
