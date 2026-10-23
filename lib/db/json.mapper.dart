// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'json.dart';

class JsonRepoMapper extends ClassMapperBase<JsonRepo> {
  JsonRepoMapper._();

  static JsonRepoMapper? _instance;
  static JsonRepoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = JsonRepoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'JsonRepo';

  static List<Map<String, dynamic>> _$decks(JsonRepo v) => v.decks;
  static const Field<JsonRepo, List<Map<String, dynamic>>> _f$decks = Field(
    'decks',
    _$decks,
  );
  static List<Map<String, dynamic>> _$cards(JsonRepo v) => v.cards;
  static const Field<JsonRepo, List<Map<String, dynamic>>> _f$cards = Field(
    'cards',
    _$cards,
  );
  static List<Map<String, dynamic>> _$reviewLogs(JsonRepo v) => v.reviewLogs;
  static const Field<JsonRepo, List<Map<String, dynamic>>> _f$reviewLogs =
      Field('reviewLogs', _$reviewLogs);

  @override
  final MappableFields<JsonRepo> fields = const {
    #decks: _f$decks,
    #cards: _f$cards,
    #reviewLogs: _f$reviewLogs,
  };

  static JsonRepo _instantiate(DecodingData data) {
    return JsonRepo(
      data.dec(_f$decks),
      data.dec(_f$cards),
      data.dec(_f$reviewLogs),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static JsonRepo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<JsonRepo>(map);
  }

  static JsonRepo fromJson(String json) {
    return ensureInitialized().decodeJson<JsonRepo>(json);
  }
}

mixin JsonRepoMappable {
  String toJson() {
    return JsonRepoMapper.ensureInitialized().encodeJson<JsonRepo>(
      this as JsonRepo,
    );
  }

  Map<String, dynamic> toMap() {
    return JsonRepoMapper.ensureInitialized().encodeMap<JsonRepo>(
      this as JsonRepo,
    );
  }

  JsonRepoCopyWith<JsonRepo, JsonRepo, JsonRepo> get copyWith =>
      _JsonRepoCopyWithImpl<JsonRepo, JsonRepo>(
        this as JsonRepo,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return JsonRepoMapper.ensureInitialized().stringifyValue(this as JsonRepo);
  }

  @override
  bool operator ==(Object other) {
    return JsonRepoMapper.ensureInitialized().equalsValue(
      this as JsonRepo,
      other,
    );
  }

  @override
  int get hashCode {
    return JsonRepoMapper.ensureInitialized().hashValue(this as JsonRepo);
  }
}

extension JsonRepoValueCopy<$R, $Out> on ObjectCopyWith<$R, JsonRepo, $Out> {
  JsonRepoCopyWith<$R, JsonRepo, $Out> get $asJsonRepo =>
      $base.as((v, t, t2) => _JsonRepoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class JsonRepoCopyWith<$R, $In extends JsonRepo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    Map<String, dynamic>,
    ObjectCopyWith<$R, Map<String, dynamic>, Map<String, dynamic>>
  >
  get decks;
  ListCopyWith<
    $R,
    Map<String, dynamic>,
    ObjectCopyWith<$R, Map<String, dynamic>, Map<String, dynamic>>
  >
  get cards;
  ListCopyWith<
    $R,
    Map<String, dynamic>,
    ObjectCopyWith<$R, Map<String, dynamic>, Map<String, dynamic>>
  >
  get reviewLogs;
  $R call({
    List<Map<String, dynamic>>? decks,
    List<Map<String, dynamic>>? cards,
    List<Map<String, dynamic>>? reviewLogs,
  });
  JsonRepoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _JsonRepoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, JsonRepo, $Out>
    implements JsonRepoCopyWith<$R, JsonRepo, $Out> {
  _JsonRepoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<JsonRepo> $mapper =
      JsonRepoMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    Map<String, dynamic>,
    ObjectCopyWith<$R, Map<String, dynamic>, Map<String, dynamic>>
  >
  get decks => ListCopyWith(
    $value.decks,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(decks: v),
  );
  @override
  ListCopyWith<
    $R,
    Map<String, dynamic>,
    ObjectCopyWith<$R, Map<String, dynamic>, Map<String, dynamic>>
  >
  get cards => ListCopyWith(
    $value.cards,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(cards: v),
  );
  @override
  ListCopyWith<
    $R,
    Map<String, dynamic>,
    ObjectCopyWith<$R, Map<String, dynamic>, Map<String, dynamic>>
  >
  get reviewLogs => ListCopyWith(
    $value.reviewLogs,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(reviewLogs: v),
  );
  @override
  $R call({
    List<Map<String, dynamic>>? decks,
    List<Map<String, dynamic>>? cards,
    List<Map<String, dynamic>>? reviewLogs,
  }) => $apply(
    FieldCopyWithData({
      if (decks != null) #decks: decks,
      if (cards != null) #cards: cards,
      if (reviewLogs != null) #reviewLogs: reviewLogs,
    }),
  );
  @override
  JsonRepo $make(CopyWithData data) => JsonRepo(
    data.get(#decks, or: $value.decks),
    data.get(#cards, or: $value.cards),
    data.get(#reviewLogs, or: $value.reviewLogs),
  );

  @override
  JsonRepoCopyWith<$R2, JsonRepo, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _JsonRepoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

