// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'json.dart';

class JsonExportMapper extends ClassMapperBase<JsonExport> {
  JsonExportMapper._();

  static JsonExportMapper? _instance;
  static JsonExportMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = JsonExportMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'JsonExport';

  static List<Map<String, dynamic>> _$methods(JsonExport v) => v.methods;
  static const Field<JsonExport, List<Map<String, dynamic>>> _f$methods = Field(
    'methods',
    _$methods,
  );
  static List<Map<String, dynamic>> _$cards(JsonExport v) => v.cards;
  static const Field<JsonExport, List<Map<String, dynamic>>> _f$cards = Field(
    'cards',
    _$cards,
  );
  static List<Map<String, dynamic>> _$reviewLogs(JsonExport v) => v.reviewLogs;
  static const Field<JsonExport, List<Map<String, dynamic>>> _f$reviewLogs =
      Field('reviewLogs', _$reviewLogs);

  @override
  final MappableFields<JsonExport> fields = const {
    #methods: _f$methods,
    #cards: _f$cards,
    #reviewLogs: _f$reviewLogs,
  };

  static JsonExport _instantiate(DecodingData data) {
    return JsonExport(
      methods: data.dec(_f$methods),
      cards: data.dec(_f$cards),
      reviewLogs: data.dec(_f$reviewLogs),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static JsonExport fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<JsonExport>(map);
  }

  static JsonExport fromJson(String json) {
    return ensureInitialized().decodeJson<JsonExport>(json);
  }
}

mixin JsonExportMappable {
  String toJson() {
    return JsonExportMapper.ensureInitialized().encodeJson<JsonExport>(
      this as JsonExport,
    );
  }

  Map<String, dynamic> toMap() {
    return JsonExportMapper.ensureInitialized().encodeMap<JsonExport>(
      this as JsonExport,
    );
  }

  JsonExportCopyWith<JsonExport, JsonExport, JsonExport> get copyWith =>
      _JsonExportCopyWithImpl<JsonExport, JsonExport>(
        this as JsonExport,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return JsonExportMapper.ensureInitialized().stringifyValue(
      this as JsonExport,
    );
  }

  @override
  bool operator ==(Object other) {
    return JsonExportMapper.ensureInitialized().equalsValue(
      this as JsonExport,
      other,
    );
  }

  @override
  int get hashCode {
    return JsonExportMapper.ensureInitialized().hashValue(this as JsonExport);
  }
}

extension JsonExportValueCopy<$R, $Out>
    on ObjectCopyWith<$R, JsonExport, $Out> {
  JsonExportCopyWith<$R, JsonExport, $Out> get $asJsonExport =>
      $base.as((v, t, t2) => _JsonExportCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class JsonExportCopyWith<$R, $In extends JsonExport, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    Map<String, dynamic>,
    ObjectCopyWith<$R, Map<String, dynamic>, Map<String, dynamic>>
  >
  get methods;
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
    List<Map<String, dynamic>>? methods,
    List<Map<String, dynamic>>? cards,
    List<Map<String, dynamic>>? reviewLogs,
  });
  JsonExportCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _JsonExportCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, JsonExport, $Out>
    implements JsonExportCopyWith<$R, JsonExport, $Out> {
  _JsonExportCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<JsonExport> $mapper =
      JsonExportMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    Map<String, dynamic>,
    ObjectCopyWith<$R, Map<String, dynamic>, Map<String, dynamic>>
  >
  get methods => ListCopyWith(
    $value.methods,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(methods: v),
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
    List<Map<String, dynamic>>? methods,
    List<Map<String, dynamic>>? cards,
    List<Map<String, dynamic>>? reviewLogs,
  }) => $apply(
    FieldCopyWithData({
      if (methods != null) #methods: methods,
      if (cards != null) #cards: cards,
      if (reviewLogs != null) #reviewLogs: reviewLogs,
    }),
  );
  @override
  JsonExport $make(CopyWithData data) => JsonExport(
    methods: data.get(#methods, or: $value.methods),
    cards: data.get(#cards, or: $value.cards),
    reviewLogs: data.get(#reviewLogs, or: $value.reviewLogs),
  );

  @override
  JsonExportCopyWith<$R2, JsonExport, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _JsonExportCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

