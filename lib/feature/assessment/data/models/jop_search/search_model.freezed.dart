// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) {
  return _SearchResult.fromJson(json);
}

/// @nodoc
mixin _$SearchResult {
  List<OrganicResult> get organic => throw _privateConstructorUsedError;

  /// Serializes this SearchResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchResultCopyWith<SearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchResultCopyWith<$Res> {
  factory $SearchResultCopyWith(
    SearchResult value,
    $Res Function(SearchResult) then,
  ) = _$SearchResultCopyWithImpl<$Res, SearchResult>;
  @useResult
  $Res call({List<OrganicResult> organic});
}

/// @nodoc
class _$SearchResultCopyWithImpl<$Res, $Val extends SearchResult>
    implements $SearchResultCopyWith<$Res> {
  _$SearchResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? organic = null}) {
    return _then(
      _value.copyWith(
            organic: null == organic
                ? _value.organic
                : organic // ignore: cast_nullable_to_non_nullable
                      as List<OrganicResult>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SearchResultImplCopyWith<$Res>
    implements $SearchResultCopyWith<$Res> {
  factory _$$SearchResultImplCopyWith(
    _$SearchResultImpl value,
    $Res Function(_$SearchResultImpl) then,
  ) = __$$SearchResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<OrganicResult> organic});
}

/// @nodoc
class __$$SearchResultImplCopyWithImpl<$Res>
    extends _$SearchResultCopyWithImpl<$Res, _$SearchResultImpl>
    implements _$$SearchResultImplCopyWith<$Res> {
  __$$SearchResultImplCopyWithImpl(
    _$SearchResultImpl _value,
    $Res Function(_$SearchResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? organic = null}) {
    return _then(
      _$SearchResultImpl(
        organic: null == organic
            ? _value._organic
            : organic // ignore: cast_nullable_to_non_nullable
                  as List<OrganicResult>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchResultImpl implements _SearchResult {
  const _$SearchResultImpl({required final List<OrganicResult> organic})
    : _organic = organic;

  factory _$SearchResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchResultImplFromJson(json);

  final List<OrganicResult> _organic;
  @override
  List<OrganicResult> get organic {
    if (_organic is EqualUnmodifiableListView) return _organic;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_organic);
  }

  @override
  String toString() {
    return 'SearchResult(organic: $organic)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchResultImpl &&
            const DeepCollectionEquality().equals(other._organic, _organic));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_organic));

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchResultImplCopyWith<_$SearchResultImpl> get copyWith =>
      __$$SearchResultImplCopyWithImpl<_$SearchResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchResultImplToJson(this);
  }
}

abstract class _SearchResult implements SearchResult {
  const factory _SearchResult({required final List<OrganicResult> organic}) =
      _$SearchResultImpl;

  factory _SearchResult.fromJson(Map<String, dynamic> json) =
      _$SearchResultImpl.fromJson;

  @override
  List<OrganicResult> get organic;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchResultImplCopyWith<_$SearchResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrganicResult _$OrganicResultFromJson(Map<String, dynamic> json) {
  return _OrganicResult.fromJson(json);
}

/// @nodoc
mixin _$OrganicResult {
  String get title => throw _privateConstructorUsedError;
  String get link => throw _privateConstructorUsedError;

  /// Serializes this OrganicResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrganicResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrganicResultCopyWith<OrganicResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganicResultCopyWith<$Res> {
  factory $OrganicResultCopyWith(
    OrganicResult value,
    $Res Function(OrganicResult) then,
  ) = _$OrganicResultCopyWithImpl<$Res, OrganicResult>;
  @useResult
  $Res call({String title, String link});
}

/// @nodoc
class _$OrganicResultCopyWithImpl<$Res, $Val extends OrganicResult>
    implements $OrganicResultCopyWith<$Res> {
  _$OrganicResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrganicResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = null, Object? link = null}) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            link: null == link
                ? _value.link
                : link // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrganicResultImplCopyWith<$Res>
    implements $OrganicResultCopyWith<$Res> {
  factory _$$OrganicResultImplCopyWith(
    _$OrganicResultImpl value,
    $Res Function(_$OrganicResultImpl) then,
  ) = __$$OrganicResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String link});
}

/// @nodoc
class __$$OrganicResultImplCopyWithImpl<$Res>
    extends _$OrganicResultCopyWithImpl<$Res, _$OrganicResultImpl>
    implements _$$OrganicResultImplCopyWith<$Res> {
  __$$OrganicResultImplCopyWithImpl(
    _$OrganicResultImpl _value,
    $Res Function(_$OrganicResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrganicResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = null, Object? link = null}) {
    return _then(
      _$OrganicResultImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        link: null == link
            ? _value.link
            : link // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrganicResultImpl implements _OrganicResult {
  const _$OrganicResultImpl({required this.title, required this.link});

  factory _$OrganicResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrganicResultImplFromJson(json);

  @override
  final String title;
  @override
  final String link;

  @override
  String toString() {
    return 'OrganicResult(title: $title, link: $link)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganicResultImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.link, link) || other.link == link));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, link);

  /// Create a copy of OrganicResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganicResultImplCopyWith<_$OrganicResultImpl> get copyWith =>
      __$$OrganicResultImplCopyWithImpl<_$OrganicResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganicResultImplToJson(this);
  }
}

abstract class _OrganicResult implements OrganicResult {
  const factory _OrganicResult({
    required final String title,
    required final String link,
  }) = _$OrganicResultImpl;

  factory _OrganicResult.fromJson(Map<String, dynamic> json) =
      _$OrganicResultImpl.fromJson;

  @override
  String get title;
  @override
  String get link;

  /// Create a copy of OrganicResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrganicResultImplCopyWith<_$OrganicResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
