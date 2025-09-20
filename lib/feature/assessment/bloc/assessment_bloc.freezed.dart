// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assessment_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AssessmentEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? level) started,
    required TResult Function(String questionId, String answer) answerSubmitted,
    required TResult Function() prevQuestion,
    required TResult Function() analysisRequested,
    required TResult Function(AnalysisResult result) saveResult,
    required TResult Function(AnalysisResult result) analysisComplete,
    required TResult Function() reset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? level)? started,
    TResult? Function(String questionId, String answer)? answerSubmitted,
    TResult? Function()? prevQuestion,
    TResult? Function()? analysisRequested,
    TResult? Function(AnalysisResult result)? saveResult,
    TResult? Function(AnalysisResult result)? analysisComplete,
    TResult? Function()? reset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? level)? started,
    TResult Function(String questionId, String answer)? answerSubmitted,
    TResult Function()? prevQuestion,
    TResult Function()? analysisRequested,
    TResult Function(AnalysisResult result)? saveResult,
    TResult Function(AnalysisResult result)? analysisComplete,
    TResult Function()? reset,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AssessmentStarted value) started,
    required TResult Function(AnswerSubmitted value) answerSubmitted,
    required TResult Function(PrevQuestion value) prevQuestion,
    required TResult Function(AnalysisRequested value) analysisRequested,
    required TResult Function(_SaveResult value) saveResult,
    required TResult Function(AnalysisComplete value) analysisComplete,
    required TResult Function(ResetAssessment value) reset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AssessmentStarted value)? started,
    TResult? Function(AnswerSubmitted value)? answerSubmitted,
    TResult? Function(PrevQuestion value)? prevQuestion,
    TResult? Function(AnalysisRequested value)? analysisRequested,
    TResult? Function(_SaveResult value)? saveResult,
    TResult? Function(AnalysisComplete value)? analysisComplete,
    TResult? Function(ResetAssessment value)? reset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AssessmentStarted value)? started,
    TResult Function(AnswerSubmitted value)? answerSubmitted,
    TResult Function(PrevQuestion value)? prevQuestion,
    TResult Function(AnalysisRequested value)? analysisRequested,
    TResult Function(_SaveResult value)? saveResult,
    TResult Function(AnalysisComplete value)? analysisComplete,
    TResult Function(ResetAssessment value)? reset,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssessmentEventCopyWith<$Res> {
  factory $AssessmentEventCopyWith(
    AssessmentEvent value,
    $Res Function(AssessmentEvent) then,
  ) = _$AssessmentEventCopyWithImpl<$Res, AssessmentEvent>;
}

/// @nodoc
class _$AssessmentEventCopyWithImpl<$Res, $Val extends AssessmentEvent>
    implements $AssessmentEventCopyWith<$Res> {
  _$AssessmentEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssessmentEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AssessmentStartedImplCopyWith<$Res> {
  factory _$$AssessmentStartedImplCopyWith(
    _$AssessmentStartedImpl value,
    $Res Function(_$AssessmentStartedImpl) then,
  ) = __$$AssessmentStartedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? level});
}

/// @nodoc
class __$$AssessmentStartedImplCopyWithImpl<$Res>
    extends _$AssessmentEventCopyWithImpl<$Res, _$AssessmentStartedImpl>
    implements _$$AssessmentStartedImplCopyWith<$Res> {
  __$$AssessmentStartedImplCopyWithImpl(
    _$AssessmentStartedImpl _value,
    $Res Function(_$AssessmentStartedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssessmentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? level = freezed}) {
    return _then(
      _$AssessmentStartedImpl(
        level: freezed == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AssessmentStartedImpl implements AssessmentStarted {
  const _$AssessmentStartedImpl({this.level});

  @override
  final String? level;

  @override
  String toString() {
    return 'AssessmentEvent.started(level: $level)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssessmentStartedImpl &&
            (identical(other.level, level) || other.level == level));
  }

  @override
  int get hashCode => Object.hash(runtimeType, level);

  /// Create a copy of AssessmentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssessmentStartedImplCopyWith<_$AssessmentStartedImpl> get copyWith =>
      __$$AssessmentStartedImplCopyWithImpl<_$AssessmentStartedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? level) started,
    required TResult Function(String questionId, String answer) answerSubmitted,
    required TResult Function() prevQuestion,
    required TResult Function() analysisRequested,
    required TResult Function(AnalysisResult result) saveResult,
    required TResult Function(AnalysisResult result) analysisComplete,
    required TResult Function() reset,
  }) {
    return started(level);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? level)? started,
    TResult? Function(String questionId, String answer)? answerSubmitted,
    TResult? Function()? prevQuestion,
    TResult? Function()? analysisRequested,
    TResult? Function(AnalysisResult result)? saveResult,
    TResult? Function(AnalysisResult result)? analysisComplete,
    TResult? Function()? reset,
  }) {
    return started?.call(level);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? level)? started,
    TResult Function(String questionId, String answer)? answerSubmitted,
    TResult Function()? prevQuestion,
    TResult Function()? analysisRequested,
    TResult Function(AnalysisResult result)? saveResult,
    TResult Function(AnalysisResult result)? analysisComplete,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(level);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AssessmentStarted value) started,
    required TResult Function(AnswerSubmitted value) answerSubmitted,
    required TResult Function(PrevQuestion value) prevQuestion,
    required TResult Function(AnalysisRequested value) analysisRequested,
    required TResult Function(_SaveResult value) saveResult,
    required TResult Function(AnalysisComplete value) analysisComplete,
    required TResult Function(ResetAssessment value) reset,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AssessmentStarted value)? started,
    TResult? Function(AnswerSubmitted value)? answerSubmitted,
    TResult? Function(PrevQuestion value)? prevQuestion,
    TResult? Function(AnalysisRequested value)? analysisRequested,
    TResult? Function(_SaveResult value)? saveResult,
    TResult? Function(AnalysisComplete value)? analysisComplete,
    TResult? Function(ResetAssessment value)? reset,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AssessmentStarted value)? started,
    TResult Function(AnswerSubmitted value)? answerSubmitted,
    TResult Function(PrevQuestion value)? prevQuestion,
    TResult Function(AnalysisRequested value)? analysisRequested,
    TResult Function(_SaveResult value)? saveResult,
    TResult Function(AnalysisComplete value)? analysisComplete,
    TResult Function(ResetAssessment value)? reset,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class AssessmentStarted implements AssessmentEvent {
  const factory AssessmentStarted({final String? level}) =
      _$AssessmentStartedImpl;

  String? get level;

  /// Create a copy of AssessmentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssessmentStartedImplCopyWith<_$AssessmentStartedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AnswerSubmittedImplCopyWith<$Res> {
  factory _$$AnswerSubmittedImplCopyWith(
    _$AnswerSubmittedImpl value,
    $Res Function(_$AnswerSubmittedImpl) then,
  ) = __$$AnswerSubmittedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String questionId, String answer});
}

/// @nodoc
class __$$AnswerSubmittedImplCopyWithImpl<$Res>
    extends _$AssessmentEventCopyWithImpl<$Res, _$AnswerSubmittedImpl>
    implements _$$AnswerSubmittedImplCopyWith<$Res> {
  __$$AnswerSubmittedImplCopyWithImpl(
    _$AnswerSubmittedImpl _value,
    $Res Function(_$AnswerSubmittedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssessmentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? questionId = null, Object? answer = null}) {
    return _then(
      _$AnswerSubmittedImpl(
        null == questionId
            ? _value.questionId
            : questionId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == answer
            ? _value.answer
            : answer // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AnswerSubmittedImpl implements AnswerSubmitted {
  const _$AnswerSubmittedImpl(this.questionId, this.answer);

  @override
  final String questionId;
  @override
  final String answer;

  @override
  String toString() {
    return 'AssessmentEvent.answerSubmitted(questionId: $questionId, answer: $answer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnswerSubmittedImpl &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.answer, answer) || other.answer == answer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, questionId, answer);

  /// Create a copy of AssessmentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnswerSubmittedImplCopyWith<_$AnswerSubmittedImpl> get copyWith =>
      __$$AnswerSubmittedImplCopyWithImpl<_$AnswerSubmittedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? level) started,
    required TResult Function(String questionId, String answer) answerSubmitted,
    required TResult Function() prevQuestion,
    required TResult Function() analysisRequested,
    required TResult Function(AnalysisResult result) saveResult,
    required TResult Function(AnalysisResult result) analysisComplete,
    required TResult Function() reset,
  }) {
    return answerSubmitted(questionId, answer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? level)? started,
    TResult? Function(String questionId, String answer)? answerSubmitted,
    TResult? Function()? prevQuestion,
    TResult? Function()? analysisRequested,
    TResult? Function(AnalysisResult result)? saveResult,
    TResult? Function(AnalysisResult result)? analysisComplete,
    TResult? Function()? reset,
  }) {
    return answerSubmitted?.call(questionId, answer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? level)? started,
    TResult Function(String questionId, String answer)? answerSubmitted,
    TResult Function()? prevQuestion,
    TResult Function()? analysisRequested,
    TResult Function(AnalysisResult result)? saveResult,
    TResult Function(AnalysisResult result)? analysisComplete,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (answerSubmitted != null) {
      return answerSubmitted(questionId, answer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AssessmentStarted value) started,
    required TResult Function(AnswerSubmitted value) answerSubmitted,
    required TResult Function(PrevQuestion value) prevQuestion,
    required TResult Function(AnalysisRequested value) analysisRequested,
    required TResult Function(_SaveResult value) saveResult,
    required TResult Function(AnalysisComplete value) analysisComplete,
    required TResult Function(ResetAssessment value) reset,
  }) {
    return answerSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AssessmentStarted value)? started,
    TResult? Function(AnswerSubmitted value)? answerSubmitted,
    TResult? Function(PrevQuestion value)? prevQuestion,
    TResult? Function(AnalysisRequested value)? analysisRequested,
    TResult? Function(_SaveResult value)? saveResult,
    TResult? Function(AnalysisComplete value)? analysisComplete,
    TResult? Function(ResetAssessment value)? reset,
  }) {
    return answerSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AssessmentStarted value)? started,
    TResult Function(AnswerSubmitted value)? answerSubmitted,
    TResult Function(PrevQuestion value)? prevQuestion,
    TResult Function(AnalysisRequested value)? analysisRequested,
    TResult Function(_SaveResult value)? saveResult,
    TResult Function(AnalysisComplete value)? analysisComplete,
    TResult Function(ResetAssessment value)? reset,
    required TResult orElse(),
  }) {
    if (answerSubmitted != null) {
      return answerSubmitted(this);
    }
    return orElse();
  }
}

abstract class AnswerSubmitted implements AssessmentEvent {
  const factory AnswerSubmitted(final String questionId, final String answer) =
      _$AnswerSubmittedImpl;

  String get questionId;
  String get answer;

  /// Create a copy of AssessmentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnswerSubmittedImplCopyWith<_$AnswerSubmittedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PrevQuestionImplCopyWith<$Res> {
  factory _$$PrevQuestionImplCopyWith(
    _$PrevQuestionImpl value,
    $Res Function(_$PrevQuestionImpl) then,
  ) = __$$PrevQuestionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PrevQuestionImplCopyWithImpl<$Res>
    extends _$AssessmentEventCopyWithImpl<$Res, _$PrevQuestionImpl>
    implements _$$PrevQuestionImplCopyWith<$Res> {
  __$$PrevQuestionImplCopyWithImpl(
    _$PrevQuestionImpl _value,
    $Res Function(_$PrevQuestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssessmentEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PrevQuestionImpl implements PrevQuestion {
  const _$PrevQuestionImpl();

  @override
  String toString() {
    return 'AssessmentEvent.prevQuestion()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PrevQuestionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? level) started,
    required TResult Function(String questionId, String answer) answerSubmitted,
    required TResult Function() prevQuestion,
    required TResult Function() analysisRequested,
    required TResult Function(AnalysisResult result) saveResult,
    required TResult Function(AnalysisResult result) analysisComplete,
    required TResult Function() reset,
  }) {
    return prevQuestion();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? level)? started,
    TResult? Function(String questionId, String answer)? answerSubmitted,
    TResult? Function()? prevQuestion,
    TResult? Function()? analysisRequested,
    TResult? Function(AnalysisResult result)? saveResult,
    TResult? Function(AnalysisResult result)? analysisComplete,
    TResult? Function()? reset,
  }) {
    return prevQuestion?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? level)? started,
    TResult Function(String questionId, String answer)? answerSubmitted,
    TResult Function()? prevQuestion,
    TResult Function()? analysisRequested,
    TResult Function(AnalysisResult result)? saveResult,
    TResult Function(AnalysisResult result)? analysisComplete,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (prevQuestion != null) {
      return prevQuestion();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AssessmentStarted value) started,
    required TResult Function(AnswerSubmitted value) answerSubmitted,
    required TResult Function(PrevQuestion value) prevQuestion,
    required TResult Function(AnalysisRequested value) analysisRequested,
    required TResult Function(_SaveResult value) saveResult,
    required TResult Function(AnalysisComplete value) analysisComplete,
    required TResult Function(ResetAssessment value) reset,
  }) {
    return prevQuestion(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AssessmentStarted value)? started,
    TResult? Function(AnswerSubmitted value)? answerSubmitted,
    TResult? Function(PrevQuestion value)? prevQuestion,
    TResult? Function(AnalysisRequested value)? analysisRequested,
    TResult? Function(_SaveResult value)? saveResult,
    TResult? Function(AnalysisComplete value)? analysisComplete,
    TResult? Function(ResetAssessment value)? reset,
  }) {
    return prevQuestion?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AssessmentStarted value)? started,
    TResult Function(AnswerSubmitted value)? answerSubmitted,
    TResult Function(PrevQuestion value)? prevQuestion,
    TResult Function(AnalysisRequested value)? analysisRequested,
    TResult Function(_SaveResult value)? saveResult,
    TResult Function(AnalysisComplete value)? analysisComplete,
    TResult Function(ResetAssessment value)? reset,
    required TResult orElse(),
  }) {
    if (prevQuestion != null) {
      return prevQuestion(this);
    }
    return orElse();
  }
}

abstract class PrevQuestion implements AssessmentEvent {
  const factory PrevQuestion() = _$PrevQuestionImpl;
}

/// @nodoc
abstract class _$$AnalysisRequestedImplCopyWith<$Res> {
  factory _$$AnalysisRequestedImplCopyWith(
    _$AnalysisRequestedImpl value,
    $Res Function(_$AnalysisRequestedImpl) then,
  ) = __$$AnalysisRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AnalysisRequestedImplCopyWithImpl<$Res>
    extends _$AssessmentEventCopyWithImpl<$Res, _$AnalysisRequestedImpl>
    implements _$$AnalysisRequestedImplCopyWith<$Res> {
  __$$AnalysisRequestedImplCopyWithImpl(
    _$AnalysisRequestedImpl _value,
    $Res Function(_$AnalysisRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssessmentEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AnalysisRequestedImpl implements AnalysisRequested {
  const _$AnalysisRequestedImpl();

  @override
  String toString() {
    return 'AssessmentEvent.analysisRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AnalysisRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? level) started,
    required TResult Function(String questionId, String answer) answerSubmitted,
    required TResult Function() prevQuestion,
    required TResult Function() analysisRequested,
    required TResult Function(AnalysisResult result) saveResult,
    required TResult Function(AnalysisResult result) analysisComplete,
    required TResult Function() reset,
  }) {
    return analysisRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? level)? started,
    TResult? Function(String questionId, String answer)? answerSubmitted,
    TResult? Function()? prevQuestion,
    TResult? Function()? analysisRequested,
    TResult? Function(AnalysisResult result)? saveResult,
    TResult? Function(AnalysisResult result)? analysisComplete,
    TResult? Function()? reset,
  }) {
    return analysisRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? level)? started,
    TResult Function(String questionId, String answer)? answerSubmitted,
    TResult Function()? prevQuestion,
    TResult Function()? analysisRequested,
    TResult Function(AnalysisResult result)? saveResult,
    TResult Function(AnalysisResult result)? analysisComplete,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (analysisRequested != null) {
      return analysisRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AssessmentStarted value) started,
    required TResult Function(AnswerSubmitted value) answerSubmitted,
    required TResult Function(PrevQuestion value) prevQuestion,
    required TResult Function(AnalysisRequested value) analysisRequested,
    required TResult Function(_SaveResult value) saveResult,
    required TResult Function(AnalysisComplete value) analysisComplete,
    required TResult Function(ResetAssessment value) reset,
  }) {
    return analysisRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AssessmentStarted value)? started,
    TResult? Function(AnswerSubmitted value)? answerSubmitted,
    TResult? Function(PrevQuestion value)? prevQuestion,
    TResult? Function(AnalysisRequested value)? analysisRequested,
    TResult? Function(_SaveResult value)? saveResult,
    TResult? Function(AnalysisComplete value)? analysisComplete,
    TResult? Function(ResetAssessment value)? reset,
  }) {
    return analysisRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AssessmentStarted value)? started,
    TResult Function(AnswerSubmitted value)? answerSubmitted,
    TResult Function(PrevQuestion value)? prevQuestion,
    TResult Function(AnalysisRequested value)? analysisRequested,
    TResult Function(_SaveResult value)? saveResult,
    TResult Function(AnalysisComplete value)? analysisComplete,
    TResult Function(ResetAssessment value)? reset,
    required TResult orElse(),
  }) {
    if (analysisRequested != null) {
      return analysisRequested(this);
    }
    return orElse();
  }
}

abstract class AnalysisRequested implements AssessmentEvent {
  const factory AnalysisRequested() = _$AnalysisRequestedImpl;
}

/// @nodoc
abstract class _$$SaveResultImplCopyWith<$Res> {
  factory _$$SaveResultImplCopyWith(
    _$SaveResultImpl value,
    $Res Function(_$SaveResultImpl) then,
  ) = __$$SaveResultImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AnalysisResult result});

  $AnalysisResultCopyWith<$Res> get result;
}

/// @nodoc
class __$$SaveResultImplCopyWithImpl<$Res>
    extends _$AssessmentEventCopyWithImpl<$Res, _$SaveResultImpl>
    implements _$$SaveResultImplCopyWith<$Res> {
  __$$SaveResultImplCopyWithImpl(
    _$SaveResultImpl _value,
    $Res Function(_$SaveResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssessmentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? result = null}) {
    return _then(
      _$SaveResultImpl(
        null == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as AnalysisResult,
      ),
    );
  }

  /// Create a copy of AssessmentEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AnalysisResultCopyWith<$Res> get result {
    return $AnalysisResultCopyWith<$Res>(_value.result, (value) {
      return _then(_value.copyWith(result: value));
    });
  }
}

/// @nodoc

class _$SaveResultImpl implements _SaveResult {
  const _$SaveResultImpl(this.result);

  @override
  final AnalysisResult result;

  @override
  String toString() {
    return 'AssessmentEvent.saveResult(result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveResultImpl &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result);

  /// Create a copy of AssessmentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveResultImplCopyWith<_$SaveResultImpl> get copyWith =>
      __$$SaveResultImplCopyWithImpl<_$SaveResultImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? level) started,
    required TResult Function(String questionId, String answer) answerSubmitted,
    required TResult Function() prevQuestion,
    required TResult Function() analysisRequested,
    required TResult Function(AnalysisResult result) saveResult,
    required TResult Function(AnalysisResult result) analysisComplete,
    required TResult Function() reset,
  }) {
    return saveResult(result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? level)? started,
    TResult? Function(String questionId, String answer)? answerSubmitted,
    TResult? Function()? prevQuestion,
    TResult? Function()? analysisRequested,
    TResult? Function(AnalysisResult result)? saveResult,
    TResult? Function(AnalysisResult result)? analysisComplete,
    TResult? Function()? reset,
  }) {
    return saveResult?.call(result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? level)? started,
    TResult Function(String questionId, String answer)? answerSubmitted,
    TResult Function()? prevQuestion,
    TResult Function()? analysisRequested,
    TResult Function(AnalysisResult result)? saveResult,
    TResult Function(AnalysisResult result)? analysisComplete,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (saveResult != null) {
      return saveResult(result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AssessmentStarted value) started,
    required TResult Function(AnswerSubmitted value) answerSubmitted,
    required TResult Function(PrevQuestion value) prevQuestion,
    required TResult Function(AnalysisRequested value) analysisRequested,
    required TResult Function(_SaveResult value) saveResult,
    required TResult Function(AnalysisComplete value) analysisComplete,
    required TResult Function(ResetAssessment value) reset,
  }) {
    return saveResult(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AssessmentStarted value)? started,
    TResult? Function(AnswerSubmitted value)? answerSubmitted,
    TResult? Function(PrevQuestion value)? prevQuestion,
    TResult? Function(AnalysisRequested value)? analysisRequested,
    TResult? Function(_SaveResult value)? saveResult,
    TResult? Function(AnalysisComplete value)? analysisComplete,
    TResult? Function(ResetAssessment value)? reset,
  }) {
    return saveResult?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AssessmentStarted value)? started,
    TResult Function(AnswerSubmitted value)? answerSubmitted,
    TResult Function(PrevQuestion value)? prevQuestion,
    TResult Function(AnalysisRequested value)? analysisRequested,
    TResult Function(_SaveResult value)? saveResult,
    TResult Function(AnalysisComplete value)? analysisComplete,
    TResult Function(ResetAssessment value)? reset,
    required TResult orElse(),
  }) {
    if (saveResult != null) {
      return saveResult(this);
    }
    return orElse();
  }
}

abstract class _SaveResult implements AssessmentEvent {
  const factory _SaveResult(final AnalysisResult result) = _$SaveResultImpl;

  AnalysisResult get result;

  /// Create a copy of AssessmentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaveResultImplCopyWith<_$SaveResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AnalysisCompleteImplCopyWith<$Res> {
  factory _$$AnalysisCompleteImplCopyWith(
    _$AnalysisCompleteImpl value,
    $Res Function(_$AnalysisCompleteImpl) then,
  ) = __$$AnalysisCompleteImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AnalysisResult result});

  $AnalysisResultCopyWith<$Res> get result;
}

/// @nodoc
class __$$AnalysisCompleteImplCopyWithImpl<$Res>
    extends _$AssessmentEventCopyWithImpl<$Res, _$AnalysisCompleteImpl>
    implements _$$AnalysisCompleteImplCopyWith<$Res> {
  __$$AnalysisCompleteImplCopyWithImpl(
    _$AnalysisCompleteImpl _value,
    $Res Function(_$AnalysisCompleteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssessmentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? result = null}) {
    return _then(
      _$AnalysisCompleteImpl(
        null == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as AnalysisResult,
      ),
    );
  }

  /// Create a copy of AssessmentEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AnalysisResultCopyWith<$Res> get result {
    return $AnalysisResultCopyWith<$Res>(_value.result, (value) {
      return _then(_value.copyWith(result: value));
    });
  }
}

/// @nodoc

class _$AnalysisCompleteImpl implements AnalysisComplete {
  const _$AnalysisCompleteImpl(this.result);

  @override
  final AnalysisResult result;

  @override
  String toString() {
    return 'AssessmentEvent.analysisComplete(result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalysisCompleteImpl &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result);

  /// Create a copy of AssessmentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalysisCompleteImplCopyWith<_$AnalysisCompleteImpl> get copyWith =>
      __$$AnalysisCompleteImplCopyWithImpl<_$AnalysisCompleteImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? level) started,
    required TResult Function(String questionId, String answer) answerSubmitted,
    required TResult Function() prevQuestion,
    required TResult Function() analysisRequested,
    required TResult Function(AnalysisResult result) saveResult,
    required TResult Function(AnalysisResult result) analysisComplete,
    required TResult Function() reset,
  }) {
    return analysisComplete(result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? level)? started,
    TResult? Function(String questionId, String answer)? answerSubmitted,
    TResult? Function()? prevQuestion,
    TResult? Function()? analysisRequested,
    TResult? Function(AnalysisResult result)? saveResult,
    TResult? Function(AnalysisResult result)? analysisComplete,
    TResult? Function()? reset,
  }) {
    return analysisComplete?.call(result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? level)? started,
    TResult Function(String questionId, String answer)? answerSubmitted,
    TResult Function()? prevQuestion,
    TResult Function()? analysisRequested,
    TResult Function(AnalysisResult result)? saveResult,
    TResult Function(AnalysisResult result)? analysisComplete,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (analysisComplete != null) {
      return analysisComplete(result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AssessmentStarted value) started,
    required TResult Function(AnswerSubmitted value) answerSubmitted,
    required TResult Function(PrevQuestion value) prevQuestion,
    required TResult Function(AnalysisRequested value) analysisRequested,
    required TResult Function(_SaveResult value) saveResult,
    required TResult Function(AnalysisComplete value) analysisComplete,
    required TResult Function(ResetAssessment value) reset,
  }) {
    return analysisComplete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AssessmentStarted value)? started,
    TResult? Function(AnswerSubmitted value)? answerSubmitted,
    TResult? Function(PrevQuestion value)? prevQuestion,
    TResult? Function(AnalysisRequested value)? analysisRequested,
    TResult? Function(_SaveResult value)? saveResult,
    TResult? Function(AnalysisComplete value)? analysisComplete,
    TResult? Function(ResetAssessment value)? reset,
  }) {
    return analysisComplete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AssessmentStarted value)? started,
    TResult Function(AnswerSubmitted value)? answerSubmitted,
    TResult Function(PrevQuestion value)? prevQuestion,
    TResult Function(AnalysisRequested value)? analysisRequested,
    TResult Function(_SaveResult value)? saveResult,
    TResult Function(AnalysisComplete value)? analysisComplete,
    TResult Function(ResetAssessment value)? reset,
    required TResult orElse(),
  }) {
    if (analysisComplete != null) {
      return analysisComplete(this);
    }
    return orElse();
  }
}

abstract class AnalysisComplete implements AssessmentEvent {
  const factory AnalysisComplete(final AnalysisResult result) =
      _$AnalysisCompleteImpl;

  AnalysisResult get result;

  /// Create a copy of AssessmentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalysisCompleteImplCopyWith<_$AnalysisCompleteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResetAssessmentImplCopyWith<$Res> {
  factory _$$ResetAssessmentImplCopyWith(
    _$ResetAssessmentImpl value,
    $Res Function(_$ResetAssessmentImpl) then,
  ) = __$$ResetAssessmentImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetAssessmentImplCopyWithImpl<$Res>
    extends _$AssessmentEventCopyWithImpl<$Res, _$ResetAssessmentImpl>
    implements _$$ResetAssessmentImplCopyWith<$Res> {
  __$$ResetAssessmentImplCopyWithImpl(
    _$ResetAssessmentImpl _value,
    $Res Function(_$ResetAssessmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssessmentEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetAssessmentImpl implements ResetAssessment {
  const _$ResetAssessmentImpl();

  @override
  String toString() {
    return 'AssessmentEvent.reset()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResetAssessmentImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? level) started,
    required TResult Function(String questionId, String answer) answerSubmitted,
    required TResult Function() prevQuestion,
    required TResult Function() analysisRequested,
    required TResult Function(AnalysisResult result) saveResult,
    required TResult Function(AnalysisResult result) analysisComplete,
    required TResult Function() reset,
  }) {
    return reset();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? level)? started,
    TResult? Function(String questionId, String answer)? answerSubmitted,
    TResult? Function()? prevQuestion,
    TResult? Function()? analysisRequested,
    TResult? Function(AnalysisResult result)? saveResult,
    TResult? Function(AnalysisResult result)? analysisComplete,
    TResult? Function()? reset,
  }) {
    return reset?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? level)? started,
    TResult Function(String questionId, String answer)? answerSubmitted,
    TResult Function()? prevQuestion,
    TResult Function()? analysisRequested,
    TResult Function(AnalysisResult result)? saveResult,
    TResult Function(AnalysisResult result)? analysisComplete,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AssessmentStarted value) started,
    required TResult Function(AnswerSubmitted value) answerSubmitted,
    required TResult Function(PrevQuestion value) prevQuestion,
    required TResult Function(AnalysisRequested value) analysisRequested,
    required TResult Function(_SaveResult value) saveResult,
    required TResult Function(AnalysisComplete value) analysisComplete,
    required TResult Function(ResetAssessment value) reset,
  }) {
    return reset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AssessmentStarted value)? started,
    TResult? Function(AnswerSubmitted value)? answerSubmitted,
    TResult? Function(PrevQuestion value)? prevQuestion,
    TResult? Function(AnalysisRequested value)? analysisRequested,
    TResult? Function(_SaveResult value)? saveResult,
    TResult? Function(AnalysisComplete value)? analysisComplete,
    TResult? Function(ResetAssessment value)? reset,
  }) {
    return reset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AssessmentStarted value)? started,
    TResult Function(AnswerSubmitted value)? answerSubmitted,
    TResult Function(PrevQuestion value)? prevQuestion,
    TResult Function(AnalysisRequested value)? analysisRequested,
    TResult Function(_SaveResult value)? saveResult,
    TResult Function(AnalysisComplete value)? analysisComplete,
    TResult Function(ResetAssessment value)? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset(this);
    }
    return orElse();
  }
}

abstract class ResetAssessment implements AssessmentEvent {
  const factory ResetAssessment() = _$ResetAssessmentImpl;
}

/// @nodoc
mixin _$AssessmentState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )
    loaded,
    required TResult Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )
    analysisComplete,
    required TResult Function(String message) error,
    required TResult Function() searchLoading,
    required TResult Function(List<OrganicResult> results) searchSuccess,
    required TResult Function(String message) searchError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )?
    loaded,
    TResult? Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )?
    analysisComplete,
    TResult? Function(String message)? error,
    TResult? Function()? searchLoading,
    TResult? Function(List<OrganicResult> results)? searchSuccess,
    TResult? Function(String message)? searchError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )?
    loaded,
    TResult Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )?
    analysisComplete,
    TResult Function(String message)? error,
    TResult Function()? searchLoading,
    TResult Function(List<OrganicResult> results)? searchSuccess,
    TResult Function(String message)? searchError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AssessmentInitial value) initial,
    required TResult Function(AssessmentLoading value) loading,
    required TResult Function(AssessmentLoaded value) loaded,
    required TResult Function(AssessmentAnalysisComplete value)
    analysisComplete,
    required TResult Function(AssessmentError value) error,
    required TResult Function(SearchLoading value) searchLoading,
    required TResult Function(SearchSuccess value) searchSuccess,
    required TResult Function(SearchError value) searchError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AssessmentInitial value)? initial,
    TResult? Function(AssessmentLoading value)? loading,
    TResult? Function(AssessmentLoaded value)? loaded,
    TResult? Function(AssessmentAnalysisComplete value)? analysisComplete,
    TResult? Function(AssessmentError value)? error,
    TResult? Function(SearchLoading value)? searchLoading,
    TResult? Function(SearchSuccess value)? searchSuccess,
    TResult? Function(SearchError value)? searchError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AssessmentInitial value)? initial,
    TResult Function(AssessmentLoading value)? loading,
    TResult Function(AssessmentLoaded value)? loaded,
    TResult Function(AssessmentAnalysisComplete value)? analysisComplete,
    TResult Function(AssessmentError value)? error,
    TResult Function(SearchLoading value)? searchLoading,
    TResult Function(SearchSuccess value)? searchSuccess,
    TResult Function(SearchError value)? searchError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssessmentStateCopyWith<$Res> {
  factory $AssessmentStateCopyWith(
    AssessmentState value,
    $Res Function(AssessmentState) then,
  ) = _$AssessmentStateCopyWithImpl<$Res, AssessmentState>;
}

/// @nodoc
class _$AssessmentStateCopyWithImpl<$Res, $Val extends AssessmentState>
    implements $AssessmentStateCopyWith<$Res> {
  _$AssessmentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AssessmentInitialImplCopyWith<$Res> {
  factory _$$AssessmentInitialImplCopyWith(
    _$AssessmentInitialImpl value,
    $Res Function(_$AssessmentInitialImpl) then,
  ) = __$$AssessmentInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AssessmentInitialImplCopyWithImpl<$Res>
    extends _$AssessmentStateCopyWithImpl<$Res, _$AssessmentInitialImpl>
    implements _$$AssessmentInitialImplCopyWith<$Res> {
  __$$AssessmentInitialImplCopyWithImpl(
    _$AssessmentInitialImpl _value,
    $Res Function(_$AssessmentInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AssessmentInitialImpl implements AssessmentInitial {
  const _$AssessmentInitialImpl();

  @override
  String toString() {
    return 'AssessmentState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AssessmentInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )
    loaded,
    required TResult Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )
    analysisComplete,
    required TResult Function(String message) error,
    required TResult Function() searchLoading,
    required TResult Function(List<OrganicResult> results) searchSuccess,
    required TResult Function(String message) searchError,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )?
    loaded,
    TResult? Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )?
    analysisComplete,
    TResult? Function(String message)? error,
    TResult? Function()? searchLoading,
    TResult? Function(List<OrganicResult> results)? searchSuccess,
    TResult? Function(String message)? searchError,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )?
    loaded,
    TResult Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )?
    analysisComplete,
    TResult Function(String message)? error,
    TResult Function()? searchLoading,
    TResult Function(List<OrganicResult> results)? searchSuccess,
    TResult Function(String message)? searchError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AssessmentInitial value) initial,
    required TResult Function(AssessmentLoading value) loading,
    required TResult Function(AssessmentLoaded value) loaded,
    required TResult Function(AssessmentAnalysisComplete value)
    analysisComplete,
    required TResult Function(AssessmentError value) error,
    required TResult Function(SearchLoading value) searchLoading,
    required TResult Function(SearchSuccess value) searchSuccess,
    required TResult Function(SearchError value) searchError,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AssessmentInitial value)? initial,
    TResult? Function(AssessmentLoading value)? loading,
    TResult? Function(AssessmentLoaded value)? loaded,
    TResult? Function(AssessmentAnalysisComplete value)? analysisComplete,
    TResult? Function(AssessmentError value)? error,
    TResult? Function(SearchLoading value)? searchLoading,
    TResult? Function(SearchSuccess value)? searchSuccess,
    TResult? Function(SearchError value)? searchError,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AssessmentInitial value)? initial,
    TResult Function(AssessmentLoading value)? loading,
    TResult Function(AssessmentLoaded value)? loaded,
    TResult Function(AssessmentAnalysisComplete value)? analysisComplete,
    TResult Function(AssessmentError value)? error,
    TResult Function(SearchLoading value)? searchLoading,
    TResult Function(SearchSuccess value)? searchSuccess,
    TResult Function(SearchError value)? searchError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AssessmentInitial implements AssessmentState {
  const factory AssessmentInitial() = _$AssessmentInitialImpl;
}

/// @nodoc
abstract class _$$AssessmentLoadingImplCopyWith<$Res> {
  factory _$$AssessmentLoadingImplCopyWith(
    _$AssessmentLoadingImpl value,
    $Res Function(_$AssessmentLoadingImpl) then,
  ) = __$$AssessmentLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AssessmentLoadingImplCopyWithImpl<$Res>
    extends _$AssessmentStateCopyWithImpl<$Res, _$AssessmentLoadingImpl>
    implements _$$AssessmentLoadingImplCopyWith<$Res> {
  __$$AssessmentLoadingImplCopyWithImpl(
    _$AssessmentLoadingImpl _value,
    $Res Function(_$AssessmentLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AssessmentLoadingImpl implements AssessmentLoading {
  const _$AssessmentLoadingImpl();

  @override
  String toString() {
    return 'AssessmentState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AssessmentLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )
    loaded,
    required TResult Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )
    analysisComplete,
    required TResult Function(String message) error,
    required TResult Function() searchLoading,
    required TResult Function(List<OrganicResult> results) searchSuccess,
    required TResult Function(String message) searchError,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )?
    loaded,
    TResult? Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )?
    analysisComplete,
    TResult? Function(String message)? error,
    TResult? Function()? searchLoading,
    TResult? Function(List<OrganicResult> results)? searchSuccess,
    TResult? Function(String message)? searchError,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )?
    loaded,
    TResult Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )?
    analysisComplete,
    TResult Function(String message)? error,
    TResult Function()? searchLoading,
    TResult Function(List<OrganicResult> results)? searchSuccess,
    TResult Function(String message)? searchError,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AssessmentInitial value) initial,
    required TResult Function(AssessmentLoading value) loading,
    required TResult Function(AssessmentLoaded value) loaded,
    required TResult Function(AssessmentAnalysisComplete value)
    analysisComplete,
    required TResult Function(AssessmentError value) error,
    required TResult Function(SearchLoading value) searchLoading,
    required TResult Function(SearchSuccess value) searchSuccess,
    required TResult Function(SearchError value) searchError,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AssessmentInitial value)? initial,
    TResult? Function(AssessmentLoading value)? loading,
    TResult? Function(AssessmentLoaded value)? loaded,
    TResult? Function(AssessmentAnalysisComplete value)? analysisComplete,
    TResult? Function(AssessmentError value)? error,
    TResult? Function(SearchLoading value)? searchLoading,
    TResult? Function(SearchSuccess value)? searchSuccess,
    TResult? Function(SearchError value)? searchError,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AssessmentInitial value)? initial,
    TResult Function(AssessmentLoading value)? loading,
    TResult Function(AssessmentLoaded value)? loaded,
    TResult Function(AssessmentAnalysisComplete value)? analysisComplete,
    TResult Function(AssessmentError value)? error,
    TResult Function(SearchLoading value)? searchLoading,
    TResult Function(SearchSuccess value)? searchSuccess,
    TResult Function(SearchError value)? searchError,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AssessmentLoading implements AssessmentState {
  const factory AssessmentLoading() = _$AssessmentLoadingImpl;
}

/// @nodoc
abstract class _$$AssessmentLoadedImplCopyWith<$Res> {
  factory _$$AssessmentLoadedImplCopyWith(
    _$AssessmentLoadedImpl value,
    $Res Function(_$AssessmentLoadedImpl) then,
  ) = __$$AssessmentLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<Map<String, dynamic>> messages,
    AssessmentQuestion? currentQuestion,
    double progress,
    int currentIndex,
  });

  $AssessmentQuestionCopyWith<$Res>? get currentQuestion;
}

/// @nodoc
class __$$AssessmentLoadedImplCopyWithImpl<$Res>
    extends _$AssessmentStateCopyWithImpl<$Res, _$AssessmentLoadedImpl>
    implements _$$AssessmentLoadedImplCopyWith<$Res> {
  __$$AssessmentLoadedImplCopyWithImpl(
    _$AssessmentLoadedImpl _value,
    $Res Function(_$AssessmentLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? currentQuestion = freezed,
    Object? progress = null,
    Object? currentIndex = null,
  }) {
    return _then(
      _$AssessmentLoadedImpl(
        messages: null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>,
        currentQuestion: freezed == currentQuestion
            ? _value.currentQuestion
            : currentQuestion // ignore: cast_nullable_to_non_nullable
                  as AssessmentQuestion?,
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as double,
        currentIndex: null == currentIndex
            ? _value.currentIndex
            : currentIndex // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AssessmentQuestionCopyWith<$Res>? get currentQuestion {
    if (_value.currentQuestion == null) {
      return null;
    }

    return $AssessmentQuestionCopyWith<$Res>(_value.currentQuestion!, (value) {
      return _then(_value.copyWith(currentQuestion: value));
    });
  }
}

/// @nodoc

class _$AssessmentLoadedImpl implements AssessmentLoaded {
  const _$AssessmentLoadedImpl({
    required final List<Map<String, dynamic>> messages,
    required this.currentQuestion,
    required this.progress,
    required this.currentIndex,
  }) : _messages = messages;

  final List<Map<String, dynamic>> _messages;
  @override
  List<Map<String, dynamic>> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  final AssessmentQuestion? currentQuestion;
  @override
  final double progress;
  @override
  final int currentIndex;

  @override
  String toString() {
    return 'AssessmentState.loaded(messages: $messages, currentQuestion: $currentQuestion, progress: $progress, currentIndex: $currentIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssessmentLoadedImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.currentQuestion, currentQuestion) ||
                other.currentQuestion == currentQuestion) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_messages),
    currentQuestion,
    progress,
    currentIndex,
  );

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssessmentLoadedImplCopyWith<_$AssessmentLoadedImpl> get copyWith =>
      __$$AssessmentLoadedImplCopyWithImpl<_$AssessmentLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )
    loaded,
    required TResult Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )
    analysisComplete,
    required TResult Function(String message) error,
    required TResult Function() searchLoading,
    required TResult Function(List<OrganicResult> results) searchSuccess,
    required TResult Function(String message) searchError,
  }) {
    return loaded(messages, currentQuestion, progress, currentIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )?
    loaded,
    TResult? Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )?
    analysisComplete,
    TResult? Function(String message)? error,
    TResult? Function()? searchLoading,
    TResult? Function(List<OrganicResult> results)? searchSuccess,
    TResult? Function(String message)? searchError,
  }) {
    return loaded?.call(messages, currentQuestion, progress, currentIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )?
    loaded,
    TResult Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )?
    analysisComplete,
    TResult Function(String message)? error,
    TResult Function()? searchLoading,
    TResult Function(List<OrganicResult> results)? searchSuccess,
    TResult Function(String message)? searchError,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(messages, currentQuestion, progress, currentIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AssessmentInitial value) initial,
    required TResult Function(AssessmentLoading value) loading,
    required TResult Function(AssessmentLoaded value) loaded,
    required TResult Function(AssessmentAnalysisComplete value)
    analysisComplete,
    required TResult Function(AssessmentError value) error,
    required TResult Function(SearchLoading value) searchLoading,
    required TResult Function(SearchSuccess value) searchSuccess,
    required TResult Function(SearchError value) searchError,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AssessmentInitial value)? initial,
    TResult? Function(AssessmentLoading value)? loading,
    TResult? Function(AssessmentLoaded value)? loaded,
    TResult? Function(AssessmentAnalysisComplete value)? analysisComplete,
    TResult? Function(AssessmentError value)? error,
    TResult? Function(SearchLoading value)? searchLoading,
    TResult? Function(SearchSuccess value)? searchSuccess,
    TResult? Function(SearchError value)? searchError,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AssessmentInitial value)? initial,
    TResult Function(AssessmentLoading value)? loading,
    TResult Function(AssessmentLoaded value)? loaded,
    TResult Function(AssessmentAnalysisComplete value)? analysisComplete,
    TResult Function(AssessmentError value)? error,
    TResult Function(SearchLoading value)? searchLoading,
    TResult Function(SearchSuccess value)? searchSuccess,
    TResult Function(SearchError value)? searchError,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class AssessmentLoaded implements AssessmentState {
  const factory AssessmentLoaded({
    required final List<Map<String, dynamic>> messages,
    required final AssessmentQuestion? currentQuestion,
    required final double progress,
    required final int currentIndex,
  }) = _$AssessmentLoadedImpl;

  List<Map<String, dynamic>> get messages;
  AssessmentQuestion? get currentQuestion;
  double get progress;
  int get currentIndex;

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssessmentLoadedImplCopyWith<_$AssessmentLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AssessmentAnalysisCompleteImplCopyWith<$Res> {
  factory _$$AssessmentAnalysisCompleteImplCopyWith(
    _$AssessmentAnalysisCompleteImpl value,
    $Res Function(_$AssessmentAnalysisCompleteImpl) then,
  ) = __$$AssessmentAnalysisCompleteImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AnalysisResult result, List<Map<String, dynamic>> messages});

  $AnalysisResultCopyWith<$Res> get result;
}

/// @nodoc
class __$$AssessmentAnalysisCompleteImplCopyWithImpl<$Res>
    extends
        _$AssessmentStateCopyWithImpl<$Res, _$AssessmentAnalysisCompleteImpl>
    implements _$$AssessmentAnalysisCompleteImplCopyWith<$Res> {
  __$$AssessmentAnalysisCompleteImplCopyWithImpl(
    _$AssessmentAnalysisCompleteImpl _value,
    $Res Function(_$AssessmentAnalysisCompleteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? result = null, Object? messages = null}) {
    return _then(
      _$AssessmentAnalysisCompleteImpl(
        result: null == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as AnalysisResult,
        messages: null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>,
      ),
    );
  }

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AnalysisResultCopyWith<$Res> get result {
    return $AnalysisResultCopyWith<$Res>(_value.result, (value) {
      return _then(_value.copyWith(result: value));
    });
  }
}

/// @nodoc

class _$AssessmentAnalysisCompleteImpl implements AssessmentAnalysisComplete {
  const _$AssessmentAnalysisCompleteImpl({
    required this.result,
    required final List<Map<String, dynamic>> messages,
  }) : _messages = messages;

  @override
  final AnalysisResult result;
  final List<Map<String, dynamic>> _messages;
  @override
  List<Map<String, dynamic>> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'AssessmentState.analysisComplete(result: $result, messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssessmentAnalysisCompleteImpl &&
            (identical(other.result, result) || other.result == result) &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    result,
    const DeepCollectionEquality().hash(_messages),
  );

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssessmentAnalysisCompleteImplCopyWith<_$AssessmentAnalysisCompleteImpl>
  get copyWith =>
      __$$AssessmentAnalysisCompleteImplCopyWithImpl<
        _$AssessmentAnalysisCompleteImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )
    loaded,
    required TResult Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )
    analysisComplete,
    required TResult Function(String message) error,
    required TResult Function() searchLoading,
    required TResult Function(List<OrganicResult> results) searchSuccess,
    required TResult Function(String message) searchError,
  }) {
    return analysisComplete(result, messages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )?
    loaded,
    TResult? Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )?
    analysisComplete,
    TResult? Function(String message)? error,
    TResult? Function()? searchLoading,
    TResult? Function(List<OrganicResult> results)? searchSuccess,
    TResult? Function(String message)? searchError,
  }) {
    return analysisComplete?.call(result, messages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )?
    loaded,
    TResult Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )?
    analysisComplete,
    TResult Function(String message)? error,
    TResult Function()? searchLoading,
    TResult Function(List<OrganicResult> results)? searchSuccess,
    TResult Function(String message)? searchError,
    required TResult orElse(),
  }) {
    if (analysisComplete != null) {
      return analysisComplete(result, messages);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AssessmentInitial value) initial,
    required TResult Function(AssessmentLoading value) loading,
    required TResult Function(AssessmentLoaded value) loaded,
    required TResult Function(AssessmentAnalysisComplete value)
    analysisComplete,
    required TResult Function(AssessmentError value) error,
    required TResult Function(SearchLoading value) searchLoading,
    required TResult Function(SearchSuccess value) searchSuccess,
    required TResult Function(SearchError value) searchError,
  }) {
    return analysisComplete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AssessmentInitial value)? initial,
    TResult? Function(AssessmentLoading value)? loading,
    TResult? Function(AssessmentLoaded value)? loaded,
    TResult? Function(AssessmentAnalysisComplete value)? analysisComplete,
    TResult? Function(AssessmentError value)? error,
    TResult? Function(SearchLoading value)? searchLoading,
    TResult? Function(SearchSuccess value)? searchSuccess,
    TResult? Function(SearchError value)? searchError,
  }) {
    return analysisComplete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AssessmentInitial value)? initial,
    TResult Function(AssessmentLoading value)? loading,
    TResult Function(AssessmentLoaded value)? loaded,
    TResult Function(AssessmentAnalysisComplete value)? analysisComplete,
    TResult Function(AssessmentError value)? error,
    TResult Function(SearchLoading value)? searchLoading,
    TResult Function(SearchSuccess value)? searchSuccess,
    TResult Function(SearchError value)? searchError,
    required TResult orElse(),
  }) {
    if (analysisComplete != null) {
      return analysisComplete(this);
    }
    return orElse();
  }
}

abstract class AssessmentAnalysisComplete implements AssessmentState {
  const factory AssessmentAnalysisComplete({
    required final AnalysisResult result,
    required final List<Map<String, dynamic>> messages,
  }) = _$AssessmentAnalysisCompleteImpl;

  AnalysisResult get result;
  List<Map<String, dynamic>> get messages;

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssessmentAnalysisCompleteImplCopyWith<_$AssessmentAnalysisCompleteImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AssessmentErrorImplCopyWith<$Res> {
  factory _$$AssessmentErrorImplCopyWith(
    _$AssessmentErrorImpl value,
    $Res Function(_$AssessmentErrorImpl) then,
  ) = __$$AssessmentErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AssessmentErrorImplCopyWithImpl<$Res>
    extends _$AssessmentStateCopyWithImpl<$Res, _$AssessmentErrorImpl>
    implements _$$AssessmentErrorImplCopyWith<$Res> {
  __$$AssessmentErrorImplCopyWithImpl(
    _$AssessmentErrorImpl _value,
    $Res Function(_$AssessmentErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$AssessmentErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AssessmentErrorImpl implements AssessmentError {
  const _$AssessmentErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AssessmentState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssessmentErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssessmentErrorImplCopyWith<_$AssessmentErrorImpl> get copyWith =>
      __$$AssessmentErrorImplCopyWithImpl<_$AssessmentErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )
    loaded,
    required TResult Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )
    analysisComplete,
    required TResult Function(String message) error,
    required TResult Function() searchLoading,
    required TResult Function(List<OrganicResult> results) searchSuccess,
    required TResult Function(String message) searchError,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )?
    loaded,
    TResult? Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )?
    analysisComplete,
    TResult? Function(String message)? error,
    TResult? Function()? searchLoading,
    TResult? Function(List<OrganicResult> results)? searchSuccess,
    TResult? Function(String message)? searchError,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )?
    loaded,
    TResult Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )?
    analysisComplete,
    TResult Function(String message)? error,
    TResult Function()? searchLoading,
    TResult Function(List<OrganicResult> results)? searchSuccess,
    TResult Function(String message)? searchError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AssessmentInitial value) initial,
    required TResult Function(AssessmentLoading value) loading,
    required TResult Function(AssessmentLoaded value) loaded,
    required TResult Function(AssessmentAnalysisComplete value)
    analysisComplete,
    required TResult Function(AssessmentError value) error,
    required TResult Function(SearchLoading value) searchLoading,
    required TResult Function(SearchSuccess value) searchSuccess,
    required TResult Function(SearchError value) searchError,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AssessmentInitial value)? initial,
    TResult? Function(AssessmentLoading value)? loading,
    TResult? Function(AssessmentLoaded value)? loaded,
    TResult? Function(AssessmentAnalysisComplete value)? analysisComplete,
    TResult? Function(AssessmentError value)? error,
    TResult? Function(SearchLoading value)? searchLoading,
    TResult? Function(SearchSuccess value)? searchSuccess,
    TResult? Function(SearchError value)? searchError,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AssessmentInitial value)? initial,
    TResult Function(AssessmentLoading value)? loading,
    TResult Function(AssessmentLoaded value)? loaded,
    TResult Function(AssessmentAnalysisComplete value)? analysisComplete,
    TResult Function(AssessmentError value)? error,
    TResult Function(SearchLoading value)? searchLoading,
    TResult Function(SearchSuccess value)? searchSuccess,
    TResult Function(SearchError value)? searchError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AssessmentError implements AssessmentState {
  const factory AssessmentError(final String message) = _$AssessmentErrorImpl;

  String get message;

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssessmentErrorImplCopyWith<_$AssessmentErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchLoadingImplCopyWith<$Res> {
  factory _$$SearchLoadingImplCopyWith(
    _$SearchLoadingImpl value,
    $Res Function(_$SearchLoadingImpl) then,
  ) = __$$SearchLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SearchLoadingImplCopyWithImpl<$Res>
    extends _$AssessmentStateCopyWithImpl<$Res, _$SearchLoadingImpl>
    implements _$$SearchLoadingImplCopyWith<$Res> {
  __$$SearchLoadingImplCopyWithImpl(
    _$SearchLoadingImpl _value,
    $Res Function(_$SearchLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SearchLoadingImpl implements SearchLoading {
  const _$SearchLoadingImpl();

  @override
  String toString() {
    return 'AssessmentState.searchLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SearchLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )
    loaded,
    required TResult Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )
    analysisComplete,
    required TResult Function(String message) error,
    required TResult Function() searchLoading,
    required TResult Function(List<OrganicResult> results) searchSuccess,
    required TResult Function(String message) searchError,
  }) {
    return searchLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )?
    loaded,
    TResult? Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )?
    analysisComplete,
    TResult? Function(String message)? error,
    TResult? Function()? searchLoading,
    TResult? Function(List<OrganicResult> results)? searchSuccess,
    TResult? Function(String message)? searchError,
  }) {
    return searchLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )?
    loaded,
    TResult Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )?
    analysisComplete,
    TResult Function(String message)? error,
    TResult Function()? searchLoading,
    TResult Function(List<OrganicResult> results)? searchSuccess,
    TResult Function(String message)? searchError,
    required TResult orElse(),
  }) {
    if (searchLoading != null) {
      return searchLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AssessmentInitial value) initial,
    required TResult Function(AssessmentLoading value) loading,
    required TResult Function(AssessmentLoaded value) loaded,
    required TResult Function(AssessmentAnalysisComplete value)
    analysisComplete,
    required TResult Function(AssessmentError value) error,
    required TResult Function(SearchLoading value) searchLoading,
    required TResult Function(SearchSuccess value) searchSuccess,
    required TResult Function(SearchError value) searchError,
  }) {
    return searchLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AssessmentInitial value)? initial,
    TResult? Function(AssessmentLoading value)? loading,
    TResult? Function(AssessmentLoaded value)? loaded,
    TResult? Function(AssessmentAnalysisComplete value)? analysisComplete,
    TResult? Function(AssessmentError value)? error,
    TResult? Function(SearchLoading value)? searchLoading,
    TResult? Function(SearchSuccess value)? searchSuccess,
    TResult? Function(SearchError value)? searchError,
  }) {
    return searchLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AssessmentInitial value)? initial,
    TResult Function(AssessmentLoading value)? loading,
    TResult Function(AssessmentLoaded value)? loaded,
    TResult Function(AssessmentAnalysisComplete value)? analysisComplete,
    TResult Function(AssessmentError value)? error,
    TResult Function(SearchLoading value)? searchLoading,
    TResult Function(SearchSuccess value)? searchSuccess,
    TResult Function(SearchError value)? searchError,
    required TResult orElse(),
  }) {
    if (searchLoading != null) {
      return searchLoading(this);
    }
    return orElse();
  }
}

abstract class SearchLoading implements AssessmentState {
  const factory SearchLoading() = _$SearchLoadingImpl;
}

/// @nodoc
abstract class _$$SearchSuccessImplCopyWith<$Res> {
  factory _$$SearchSuccessImplCopyWith(
    _$SearchSuccessImpl value,
    $Res Function(_$SearchSuccessImpl) then,
  ) = __$$SearchSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<OrganicResult> results});
}

/// @nodoc
class __$$SearchSuccessImplCopyWithImpl<$Res>
    extends _$AssessmentStateCopyWithImpl<$Res, _$SearchSuccessImpl>
    implements _$$SearchSuccessImplCopyWith<$Res> {
  __$$SearchSuccessImplCopyWithImpl(
    _$SearchSuccessImpl _value,
    $Res Function(_$SearchSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? results = null}) {
    return _then(
      _$SearchSuccessImpl(
        null == results
            ? _value._results
            : results // ignore: cast_nullable_to_non_nullable
                  as List<OrganicResult>,
      ),
    );
  }
}

/// @nodoc

class _$SearchSuccessImpl implements SearchSuccess {
  const _$SearchSuccessImpl(final List<OrganicResult> results)
    : _results = results;

  final List<OrganicResult> _results;
  @override
  List<OrganicResult> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'AssessmentState.searchSuccess(results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchSuccessImpl &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_results));

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchSuccessImplCopyWith<_$SearchSuccessImpl> get copyWith =>
      __$$SearchSuccessImplCopyWithImpl<_$SearchSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )
    loaded,
    required TResult Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )
    analysisComplete,
    required TResult Function(String message) error,
    required TResult Function() searchLoading,
    required TResult Function(List<OrganicResult> results) searchSuccess,
    required TResult Function(String message) searchError,
  }) {
    return searchSuccess(results);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )?
    loaded,
    TResult? Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )?
    analysisComplete,
    TResult? Function(String message)? error,
    TResult? Function()? searchLoading,
    TResult? Function(List<OrganicResult> results)? searchSuccess,
    TResult? Function(String message)? searchError,
  }) {
    return searchSuccess?.call(results);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )?
    loaded,
    TResult Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )?
    analysisComplete,
    TResult Function(String message)? error,
    TResult Function()? searchLoading,
    TResult Function(List<OrganicResult> results)? searchSuccess,
    TResult Function(String message)? searchError,
    required TResult orElse(),
  }) {
    if (searchSuccess != null) {
      return searchSuccess(results);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AssessmentInitial value) initial,
    required TResult Function(AssessmentLoading value) loading,
    required TResult Function(AssessmentLoaded value) loaded,
    required TResult Function(AssessmentAnalysisComplete value)
    analysisComplete,
    required TResult Function(AssessmentError value) error,
    required TResult Function(SearchLoading value) searchLoading,
    required TResult Function(SearchSuccess value) searchSuccess,
    required TResult Function(SearchError value) searchError,
  }) {
    return searchSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AssessmentInitial value)? initial,
    TResult? Function(AssessmentLoading value)? loading,
    TResult? Function(AssessmentLoaded value)? loaded,
    TResult? Function(AssessmentAnalysisComplete value)? analysisComplete,
    TResult? Function(AssessmentError value)? error,
    TResult? Function(SearchLoading value)? searchLoading,
    TResult? Function(SearchSuccess value)? searchSuccess,
    TResult? Function(SearchError value)? searchError,
  }) {
    return searchSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AssessmentInitial value)? initial,
    TResult Function(AssessmentLoading value)? loading,
    TResult Function(AssessmentLoaded value)? loaded,
    TResult Function(AssessmentAnalysisComplete value)? analysisComplete,
    TResult Function(AssessmentError value)? error,
    TResult Function(SearchLoading value)? searchLoading,
    TResult Function(SearchSuccess value)? searchSuccess,
    TResult Function(SearchError value)? searchError,
    required TResult orElse(),
  }) {
    if (searchSuccess != null) {
      return searchSuccess(this);
    }
    return orElse();
  }
}

abstract class SearchSuccess implements AssessmentState {
  const factory SearchSuccess(final List<OrganicResult> results) =
      _$SearchSuccessImpl;

  List<OrganicResult> get results;

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchSuccessImplCopyWith<_$SearchSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchErrorImplCopyWith<$Res> {
  factory _$$SearchErrorImplCopyWith(
    _$SearchErrorImpl value,
    $Res Function(_$SearchErrorImpl) then,
  ) = __$$SearchErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SearchErrorImplCopyWithImpl<$Res>
    extends _$AssessmentStateCopyWithImpl<$Res, _$SearchErrorImpl>
    implements _$$SearchErrorImplCopyWith<$Res> {
  __$$SearchErrorImplCopyWithImpl(
    _$SearchErrorImpl _value,
    $Res Function(_$SearchErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$SearchErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SearchErrorImpl implements SearchError {
  const _$SearchErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AssessmentState.searchError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchErrorImplCopyWith<_$SearchErrorImpl> get copyWith =>
      __$$SearchErrorImplCopyWithImpl<_$SearchErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )
    loaded,
    required TResult Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )
    analysisComplete,
    required TResult Function(String message) error,
    required TResult Function() searchLoading,
    required TResult Function(List<OrganicResult> results) searchSuccess,
    required TResult Function(String message) searchError,
  }) {
    return searchError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )?
    loaded,
    TResult? Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )?
    analysisComplete,
    TResult? Function(String message)? error,
    TResult? Function()? searchLoading,
    TResult? Function(List<OrganicResult> results)? searchSuccess,
    TResult? Function(String message)? searchError,
  }) {
    return searchError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Map<String, dynamic>> messages,
      AssessmentQuestion? currentQuestion,
      double progress,
      int currentIndex,
    )?
    loaded,
    TResult Function(
      AnalysisResult result,
      List<Map<String, dynamic>> messages,
    )?
    analysisComplete,
    TResult Function(String message)? error,
    TResult Function()? searchLoading,
    TResult Function(List<OrganicResult> results)? searchSuccess,
    TResult Function(String message)? searchError,
    required TResult orElse(),
  }) {
    if (searchError != null) {
      return searchError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AssessmentInitial value) initial,
    required TResult Function(AssessmentLoading value) loading,
    required TResult Function(AssessmentLoaded value) loaded,
    required TResult Function(AssessmentAnalysisComplete value)
    analysisComplete,
    required TResult Function(AssessmentError value) error,
    required TResult Function(SearchLoading value) searchLoading,
    required TResult Function(SearchSuccess value) searchSuccess,
    required TResult Function(SearchError value) searchError,
  }) {
    return searchError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AssessmentInitial value)? initial,
    TResult? Function(AssessmentLoading value)? loading,
    TResult? Function(AssessmentLoaded value)? loaded,
    TResult? Function(AssessmentAnalysisComplete value)? analysisComplete,
    TResult? Function(AssessmentError value)? error,
    TResult? Function(SearchLoading value)? searchLoading,
    TResult? Function(SearchSuccess value)? searchSuccess,
    TResult? Function(SearchError value)? searchError,
  }) {
    return searchError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AssessmentInitial value)? initial,
    TResult Function(AssessmentLoading value)? loading,
    TResult Function(AssessmentLoaded value)? loaded,
    TResult Function(AssessmentAnalysisComplete value)? analysisComplete,
    TResult Function(AssessmentError value)? error,
    TResult Function(SearchLoading value)? searchLoading,
    TResult Function(SearchSuccess value)? searchSuccess,
    TResult Function(SearchError value)? searchError,
    required TResult orElse(),
  }) {
    if (searchError != null) {
      return searchError(this);
    }
    return orElse();
  }
}

abstract class SearchError implements AssessmentState {
  const factory SearchError(final String message) = _$SearchErrorImpl;

  String get message;

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchErrorImplCopyWith<_$SearchErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
