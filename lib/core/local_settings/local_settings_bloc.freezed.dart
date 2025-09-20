// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_settings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LocalSettingsState _$LocalSettingsStateFromJson(Map<String, dynamic> json) {
  return _LocalSettingsState.fromJson(json);
}

/// @nodoc
mixin _$LocalSettingsState {
  String get local => throw _privateConstructorUsedError;
  bool get isDarkMode => throw _privateConstructorUsedError;
  String get currencyCode => throw _privateConstructorUsedError;
  String get englishFont => throw _privateConstructorUsedError;
  String get arabicFont => throw _privateConstructorUsedError;
  bool get isTable => throw _privateConstructorUsedError;

  /// Serializes this LocalSettingsState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocalSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocalSettingsStateCopyWith<LocalSettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalSettingsStateCopyWith<$Res> {
  factory $LocalSettingsStateCopyWith(
    LocalSettingsState value,
    $Res Function(LocalSettingsState) then,
  ) = _$LocalSettingsStateCopyWithImpl<$Res, LocalSettingsState>;
  @useResult
  $Res call({
    String local,
    bool isDarkMode,
    String currencyCode,
    String englishFont,
    String arabicFont,
    bool isTable,
  });
}

/// @nodoc
class _$LocalSettingsStateCopyWithImpl<$Res, $Val extends LocalSettingsState>
    implements $LocalSettingsStateCopyWith<$Res> {
  _$LocalSettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocalSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? local = null,
    Object? isDarkMode = null,
    Object? currencyCode = null,
    Object? englishFont = null,
    Object? arabicFont = null,
    Object? isTable = null,
  }) {
    return _then(
      _value.copyWith(
            local: null == local
                ? _value.local
                : local // ignore: cast_nullable_to_non_nullable
                      as String,
            isDarkMode: null == isDarkMode
                ? _value.isDarkMode
                : isDarkMode // ignore: cast_nullable_to_non_nullable
                      as bool,
            currencyCode: null == currencyCode
                ? _value.currencyCode
                : currencyCode // ignore: cast_nullable_to_non_nullable
                      as String,
            englishFont: null == englishFont
                ? _value.englishFont
                : englishFont // ignore: cast_nullable_to_non_nullable
                      as String,
            arabicFont: null == arabicFont
                ? _value.arabicFont
                : arabicFont // ignore: cast_nullable_to_non_nullable
                      as String,
            isTable: null == isTable
                ? _value.isTable
                : isTable // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LocalSettingsStateImplCopyWith<$Res>
    implements $LocalSettingsStateCopyWith<$Res> {
  factory _$$LocalSettingsStateImplCopyWith(
    _$LocalSettingsStateImpl value,
    $Res Function(_$LocalSettingsStateImpl) then,
  ) = __$$LocalSettingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String local,
    bool isDarkMode,
    String currencyCode,
    String englishFont,
    String arabicFont,
    bool isTable,
  });
}

/// @nodoc
class __$$LocalSettingsStateImplCopyWithImpl<$Res>
    extends _$LocalSettingsStateCopyWithImpl<$Res, _$LocalSettingsStateImpl>
    implements _$$LocalSettingsStateImplCopyWith<$Res> {
  __$$LocalSettingsStateImplCopyWithImpl(
    _$LocalSettingsStateImpl _value,
    $Res Function(_$LocalSettingsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocalSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? local = null,
    Object? isDarkMode = null,
    Object? currencyCode = null,
    Object? englishFont = null,
    Object? arabicFont = null,
    Object? isTable = null,
  }) {
    return _then(
      _$LocalSettingsStateImpl(
        local: null == local
            ? _value.local
            : local // ignore: cast_nullable_to_non_nullable
                  as String,
        isDarkMode: null == isDarkMode
            ? _value.isDarkMode
            : isDarkMode // ignore: cast_nullable_to_non_nullable
                  as bool,
        currencyCode: null == currencyCode
            ? _value.currencyCode
            : currencyCode // ignore: cast_nullable_to_non_nullable
                  as String,
        englishFont: null == englishFont
            ? _value.englishFont
            : englishFont // ignore: cast_nullable_to_non_nullable
                  as String,
        arabicFont: null == arabicFont
            ? _value.arabicFont
            : arabicFont // ignore: cast_nullable_to_non_nullable
                  as String,
        isTable: null == isTable
            ? _value.isTable
            : isTable // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LocalSettingsStateImpl implements _LocalSettingsState {
  const _$LocalSettingsStateImpl({
    this.local = 'ar',
    this.isDarkMode = false,
    this.currencyCode = "SAR",
    this.englishFont = 'Roboto',
    this.arabicFont = 'Cairo',
    this.isTable = false,
  });

  factory _$LocalSettingsStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocalSettingsStateImplFromJson(json);

  @override
  @JsonKey()
  final String local;
  @override
  @JsonKey()
  final bool isDarkMode;
  @override
  @JsonKey()
  final String currencyCode;
  @override
  @JsonKey()
  final String englishFont;
  @override
  @JsonKey()
  final String arabicFont;
  @override
  @JsonKey()
  final bool isTable;

  @override
  String toString() {
    return 'LocalSettingsState(local: $local, isDarkMode: $isDarkMode, currencyCode: $currencyCode, englishFont: $englishFont, arabicFont: $arabicFont, isTable: $isTable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalSettingsStateImpl &&
            (identical(other.local, local) || other.local == local) &&
            (identical(other.isDarkMode, isDarkMode) ||
                other.isDarkMode == isDarkMode) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode) &&
            (identical(other.englishFont, englishFont) ||
                other.englishFont == englishFont) &&
            (identical(other.arabicFont, arabicFont) ||
                other.arabicFont == arabicFont) &&
            (identical(other.isTable, isTable) || other.isTable == isTable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    local,
    isDarkMode,
    currencyCode,
    englishFont,
    arabicFont,
    isTable,
  );

  /// Create a copy of LocalSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalSettingsStateImplCopyWith<_$LocalSettingsStateImpl> get copyWith =>
      __$$LocalSettingsStateImplCopyWithImpl<_$LocalSettingsStateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LocalSettingsStateImplToJson(this);
  }
}

abstract class _LocalSettingsState implements LocalSettingsState {
  const factory _LocalSettingsState({
    final String local,
    final bool isDarkMode,
    final String currencyCode,
    final String englishFont,
    final String arabicFont,
    final bool isTable,
  }) = _$LocalSettingsStateImpl;

  factory _LocalSettingsState.fromJson(Map<String, dynamic> json) =
      _$LocalSettingsStateImpl.fromJson;

  @override
  String get local;
  @override
  bool get isDarkMode;
  @override
  String get currencyCode;
  @override
  String get englishFont;
  @override
  String get arabicFont;
  @override
  bool get isTable;

  /// Create a copy of LocalSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocalSettingsStateImplCopyWith<_$LocalSettingsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
