// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'model.dart';

class MethodCardMapper extends ClassMapperBase<MethodCard> {
  MethodCardMapper._();

  static MethodCardMapper? _instance;
  static MethodCardMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MethodCardMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MethodCard';

  static int _$id(MethodCard v) => v.id;
  static const Field<MethodCard, int> _f$id = Field('id', _$id);
  static fsrs.Card _$card(MethodCard v) => v.card;
  static const Field<MethodCard, fsrs.Card> _f$card = Field('card', _$card);
  static int _$method(MethodCard v) => v.method;
  static const Field<MethodCard, int> _f$method = Field('method', _$method);
  static CardType _$type(MethodCard v) => v.type;
  static const Field<MethodCard, CardType> _f$type = Field('type', _$type);
  static int _$placeBell(MethodCard v) => v.placeBell;
  static const Field<MethodCard, int> _f$placeBell = Field(
    'placeBell',
    _$placeBell,
  );
  static bool _$paused(MethodCard v) => v.paused;
  static const Field<MethodCard, bool> _f$paused = Field('paused', _$paused);
  static bool _$learned(MethodCard v) => v.learned;
  static const Field<MethodCard, bool> _f$learned = Field('learned', _$learned);

  @override
  final MappableFields<MethodCard> fields = const {
    #id: _f$id,
    #card: _f$card,
    #method: _f$method,
    #type: _f$type,
    #placeBell: _f$placeBell,
    #paused: _f$paused,
    #learned: _f$learned,
  };

  static MethodCard _instantiate(DecodingData data) {
    return MethodCard(
      id: data.dec(_f$id),
      card: data.dec(_f$card),
      method: data.dec(_f$method),
      type: data.dec(_f$type),
      placeBell: data.dec(_f$placeBell),
      paused: data.dec(_f$paused),
      learned: data.dec(_f$learned),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MethodCard fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MethodCard>(map);
  }

  static MethodCard fromJson(String json) {
    return ensureInitialized().decodeJson<MethodCard>(json);
  }
}

mixin MethodCardMappable {
  String toJson() {
    return MethodCardMapper.ensureInitialized().encodeJson<MethodCard>(
      this as MethodCard,
    );
  }

  Map<String, dynamic> toMap() {
    return MethodCardMapper.ensureInitialized().encodeMap<MethodCard>(
      this as MethodCard,
    );
  }

  MethodCardCopyWith<MethodCard, MethodCard, MethodCard> get copyWith =>
      _MethodCardCopyWithImpl<MethodCard, MethodCard>(
        this as MethodCard,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MethodCardMapper.ensureInitialized().stringifyValue(
      this as MethodCard,
    );
  }

  @override
  bool operator ==(Object other) {
    return MethodCardMapper.ensureInitialized().equalsValue(
      this as MethodCard,
      other,
    );
  }

  @override
  int get hashCode {
    return MethodCardMapper.ensureInitialized().hashValue(this as MethodCard);
  }
}

extension MethodCardValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MethodCard, $Out> {
  MethodCardCopyWith<$R, MethodCard, $Out> get $asMethodCard =>
      $base.as((v, t, t2) => _MethodCardCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MethodCardCopyWith<$R, $In extends MethodCard, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? id,
    fsrs.Card? card,
    int? method,
    CardType? type,
    int? placeBell,
    bool? paused,
    bool? learned,
  });
  MethodCardCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MethodCardCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MethodCard, $Out>
    implements MethodCardCopyWith<$R, MethodCard, $Out> {
  _MethodCardCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MethodCard> $mapper =
      MethodCardMapper.ensureInitialized();
  @override
  $R call({
    int? id,
    fsrs.Card? card,
    int? method,
    CardType? type,
    int? placeBell,
    bool? paused,
    bool? learned,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (card != null) #card: card,
      if (method != null) #method: method,
      if (type != null) #type: type,
      if (placeBell != null) #placeBell: placeBell,
      if (paused != null) #paused: paused,
      if (learned != null) #learned: learned,
    }),
  );
  @override
  MethodCard $make(CopyWithData data) => MethodCard(
    id: data.get(#id, or: $value.id),
    card: data.get(#card, or: $value.card),
    method: data.get(#method, or: $value.method),
    type: data.get(#type, or: $value.type),
    placeBell: data.get(#placeBell, or: $value.placeBell),
    paused: data.get(#paused, or: $value.paused),
    learned: data.get(#learned, or: $value.learned),
  );

  @override
  MethodCardCopyWith<$R2, MethodCard, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MethodCardCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class MethodMapper extends ClassMapperBase<Method> {
  MethodMapper._();

  static MethodMapper? _instance;
  static MethodMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MethodMapper._());
      MethodDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Method';

  static int _$id(Method v) => v.id;
  static const Field<Method, int> _f$id = Field('id', _$id);
  static MethodData _$data(Method v) => v.data;
  static const Field<Method, MethodData> _f$data = Field('data', _$data);
  static bool _$hasDeck(Method v) => v.hasDeck;
  static const Field<Method, bool> _f$hasDeck = Field('hasDeck', _$hasDeck);

  @override
  final MappableFields<Method> fields = const {
    #id: _f$id,
    #data: _f$data,
    #hasDeck: _f$hasDeck,
  };

  static Method _instantiate(DecodingData data) {
    return Method(
      id: data.dec(_f$id),
      data: data.dec(_f$data),
      hasDeck: data.dec(_f$hasDeck),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Method fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Method>(map);
  }

  static Method fromJson(String json) {
    return ensureInitialized().decodeJson<Method>(json);
  }
}

mixin MethodMappable {
  String toJson() {
    return MethodMapper.ensureInitialized().encodeJson<Method>(this as Method);
  }

  Map<String, dynamic> toMap() {
    return MethodMapper.ensureInitialized().encodeMap<Method>(this as Method);
  }

  MethodCopyWith<Method, Method, Method> get copyWith =>
      _MethodCopyWithImpl<Method, Method>(this as Method, $identity, $identity);
  @override
  String toString() {
    return MethodMapper.ensureInitialized().stringifyValue(this as Method);
  }

  @override
  bool operator ==(Object other) {
    return MethodMapper.ensureInitialized().equalsValue(this as Method, other);
  }

  @override
  int get hashCode {
    return MethodMapper.ensureInitialized().hashValue(this as Method);
  }
}

extension MethodValueCopy<$R, $Out> on ObjectCopyWith<$R, Method, $Out> {
  MethodCopyWith<$R, Method, $Out> get $asMethod =>
      $base.as((v, t, t2) => _MethodCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MethodCopyWith<$R, $In extends Method, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MethodDataCopyWith<$R, MethodData, MethodData> get data;
  $R call({int? id, MethodData? data, bool? hasDeck});
  MethodCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MethodCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Method, $Out>
    implements MethodCopyWith<$R, Method, $Out> {
  _MethodCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Method> $mapper = MethodMapper.ensureInitialized();
  @override
  MethodDataCopyWith<$R, MethodData, MethodData> get data =>
      $value.data.copyWith.$chain((v) => call(data: v));
  @override
  $R call({int? id, MethodData? data, bool? hasDeck}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (data != null) #data: data,
      if (hasDeck != null) #hasDeck: hasDeck,
    }),
  );
  @override
  Method $make(CopyWithData data) => Method(
    id: data.get(#id, or: $value.id),
    data: data.get(#data, or: $value.data),
    hasDeck: data.get(#hasDeck, or: $value.hasDeck),
  );

  @override
  MethodCopyWith<$R2, Method, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MethodCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class MethodDataMapper extends ClassMapperBase<MethodData> {
  MethodDataMapper._();

  static MethodDataMapper? _instance;
  static MethodDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MethodDataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MethodData';

  static String _$name(MethodData v) => v.name;
  static const Field<MethodData, String> _f$name = Field('name', _$name);
  static String _$placeNotation(MethodData v) => v.placeNotation;
  static const Field<MethodData, String> _f$placeNotation = Field(
    'placeNotation',
    _$placeNotation,
  );
  static int _$stage(MethodData v) => v.stage;
  static const Field<MethodData, int> _f$stage = Field('stage', _$stage);
  static int? _$libraryId(MethodData v) => v.libraryId;
  static const Field<MethodData, int> _f$libraryId = Field(
    'libraryId',
    _$libraryId,
  );

  @override
  final MappableFields<MethodData> fields = const {
    #name: _f$name,
    #placeNotation: _f$placeNotation,
    #stage: _f$stage,
    #libraryId: _f$libraryId,
  };

  static MethodData _instantiate(DecodingData data) {
    return MethodData(
      name: data.dec(_f$name),
      placeNotation: data.dec(_f$placeNotation),
      stage: data.dec(_f$stage),
      libraryId: data.dec(_f$libraryId),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MethodData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MethodData>(map);
  }

  static MethodData fromJson(String json) {
    return ensureInitialized().decodeJson<MethodData>(json);
  }
}

mixin MethodDataMappable {
  String toJson() {
    return MethodDataMapper.ensureInitialized().encodeJson<MethodData>(
      this as MethodData,
    );
  }

  Map<String, dynamic> toMap() {
    return MethodDataMapper.ensureInitialized().encodeMap<MethodData>(
      this as MethodData,
    );
  }

  MethodDataCopyWith<MethodData, MethodData, MethodData> get copyWith =>
      _MethodDataCopyWithImpl<MethodData, MethodData>(
        this as MethodData,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MethodDataMapper.ensureInitialized().stringifyValue(
      this as MethodData,
    );
  }

  @override
  bool operator ==(Object other) {
    return MethodDataMapper.ensureInitialized().equalsValue(
      this as MethodData,
      other,
    );
  }

  @override
  int get hashCode {
    return MethodDataMapper.ensureInitialized().hashValue(this as MethodData);
  }
}

extension MethodDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MethodData, $Out> {
  MethodDataCopyWith<$R, MethodData, $Out> get $asMethodData =>
      $base.as((v, t, t2) => _MethodDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MethodDataCopyWith<$R, $In extends MethodData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? placeNotation, int? stage, int? libraryId});
  MethodDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MethodDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MethodData, $Out>
    implements MethodDataCopyWith<$R, MethodData, $Out> {
  _MethodDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MethodData> $mapper =
      MethodDataMapper.ensureInitialized();
  @override
  $R call({
    String? name,
    String? placeNotation,
    int? stage,
    Object? libraryId = $none,
  }) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (placeNotation != null) #placeNotation: placeNotation,
      if (stage != null) #stage: stage,
      if (libraryId != $none) #libraryId: libraryId,
    }),
  );
  @override
  MethodData $make(CopyWithData data) => MethodData(
    name: data.get(#name, or: $value.name),
    placeNotation: data.get(#placeNotation, or: $value.placeNotation),
    stage: data.get(#stage, or: $value.stage),
    libraryId: data.get(#libraryId, or: $value.libraryId),
  );

  @override
  MethodDataCopyWith<$R2, MethodData, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MethodDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

