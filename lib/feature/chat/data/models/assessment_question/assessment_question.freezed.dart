// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assessment_question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AssessmentQuestion _$AssessmentQuestionFromJson(Map<String, dynamic> json) {
  return _AssessmentQuestion.fromJson(json);
}

/// @nodoc
mixin _$AssessmentQuestion {
  String get id => throw _privateConstructorUsedError;
  String get level => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  QuestionKind get kind => throw _privateConstructorUsedError;
  int get weight => throw _privateConstructorUsedError;
  int get timeSeconds => throw _privateConstructorUsedError;
  List<String>? get options => throw _privateConstructorUsedError;

  /// Serializes this AssessmentQuestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AssessmentQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssessmentQuestionCopyWith<AssessmentQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssessmentQuestionCopyWith<$Res> {
  factory $AssessmentQuestionCopyWith(
    AssessmentQuestion value,
    $Res Function(AssessmentQuestion) then,
  ) = _$AssessmentQuestionCopyWithImpl<$Res, AssessmentQuestion>;
  @useResult
  $Res call({
    String id,
    String level,
    String text,
    QuestionKind kind,
    int weight,
    int timeSeconds,
    List<String>? options,
  });
}

/// @nodoc
class _$AssessmentQuestionCopyWithImpl<$Res, $Val extends AssessmentQuestion>
    implements $AssessmentQuestionCopyWith<$Res> {
  _$AssessmentQuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssessmentQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? level = null,
    Object? text = null,
    Object? kind = null,
    Object? weight = null,
    Object? timeSeconds = null,
    Object? options = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as String,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            kind: null == kind
                ? _value.kind
                : kind // ignore: cast_nullable_to_non_nullable
                      as QuestionKind,
            weight: null == weight
                ? _value.weight
                : weight // ignore: cast_nullable_to_non_nullable
                      as int,
            timeSeconds: null == timeSeconds
                ? _value.timeSeconds
                : timeSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            options: freezed == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AssessmentQuestionImplCopyWith<$Res>
    implements $AssessmentQuestionCopyWith<$Res> {
  factory _$$AssessmentQuestionImplCopyWith(
    _$AssessmentQuestionImpl value,
    $Res Function(_$AssessmentQuestionImpl) then,
  ) = __$$AssessmentQuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String level,
    String text,
    QuestionKind kind,
    int weight,
    int timeSeconds,
    List<String>? options,
  });
}

/// @nodoc
class __$$AssessmentQuestionImplCopyWithImpl<$Res>
    extends _$AssessmentQuestionCopyWithImpl<$Res, _$AssessmentQuestionImpl>
    implements _$$AssessmentQuestionImplCopyWith<$Res> {
  __$$AssessmentQuestionImplCopyWithImpl(
    _$AssessmentQuestionImpl _value,
    $Res Function(_$AssessmentQuestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssessmentQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? level = null,
    Object? text = null,
    Object? kind = null,
    Object? weight = null,
    Object? timeSeconds = null,
    Object? options = freezed,
  }) {
    return _then(
      _$AssessmentQuestionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        kind: null == kind
            ? _value.kind
            : kind // ignore: cast_nullable_to_non_nullable
                  as QuestionKind,
        weight: null == weight
            ? _value.weight
            : weight // ignore: cast_nullable_to_non_nullable
                  as int,
        timeSeconds: null == timeSeconds
            ? _value.timeSeconds
            : timeSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        options: freezed == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AssessmentQuestionImpl implements _AssessmentQuestion {
  const _$AssessmentQuestionImpl({
    required this.id,
    required this.level,
    required this.text,
    required this.kind,
    required this.weight,
    required this.timeSeconds,
    final List<String>? options,
  }) : _options = options;

  factory _$AssessmentQuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssessmentQuestionImplFromJson(json);

  @override
  final String id;
  @override
  final String level;
  @override
  final String text;
  @override
  final QuestionKind kind;
  @override
  final int weight;
  @override
  final int timeSeconds;
  final List<String>? _options;
  @override
  List<String>? get options {
    final value = _options;
    if (value == null) return null;
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AssessmentQuestion(id: $id, level: $level, text: $text, kind: $kind, weight: $weight, timeSeconds: $timeSeconds, options: $options)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssessmentQuestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.timeSeconds, timeSeconds) ||
                other.timeSeconds == timeSeconds) &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    level,
    text,
    kind,
    weight,
    timeSeconds,
    const DeepCollectionEquality().hash(_options),
  );

  /// Create a copy of AssessmentQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssessmentQuestionImplCopyWith<_$AssessmentQuestionImpl> get copyWith =>
      __$$AssessmentQuestionImplCopyWithImpl<_$AssessmentQuestionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AssessmentQuestionImplToJson(this);
  }
}

abstract class _AssessmentQuestion implements AssessmentQuestion {
  const factory _AssessmentQuestion({
    required final String id,
    required final String level,
    required final String text,
    required final QuestionKind kind,
    required final int weight,
    required final int timeSeconds,
    final List<String>? options,
  }) = _$AssessmentQuestionImpl;

  factory _AssessmentQuestion.fromJson(Map<String, dynamic> json) =
      _$AssessmentQuestionImpl.fromJson;

  @override
  String get id;
  @override
  String get level;
  @override
  String get text;
  @override
  QuestionKind get kind;
  @override
  int get weight;
  @override
  int get timeSeconds;
  @override
  List<String>? get options;

  /// Create a copy of AssessmentQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssessmentQuestionImplCopyWith<_$AssessmentQuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
