// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feedback_submission.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedbackSubmission {

 String get formId; String get programId; String get userId; List<FeedbackAnswer> get answers; DateTime get submittedAt;
/// Create a copy of FeedbackSubmission
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedbackSubmissionCopyWith<FeedbackSubmission> get copyWith => _$FeedbackSubmissionCopyWithImpl<FeedbackSubmission>(this as FeedbackSubmission, _$identity);

  /// Serializes this FeedbackSubmission to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedbackSubmission&&(identical(other.formId, formId) || other.formId == formId)&&(identical(other.programId, programId) || other.programId == programId)&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other.answers, answers)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,formId,programId,userId,const DeepCollectionEquality().hash(answers),submittedAt);

@override
String toString() {
  return 'FeedbackSubmission(formId: $formId, programId: $programId, userId: $userId, answers: $answers, submittedAt: $submittedAt)';
}


}

/// @nodoc
abstract mixin class $FeedbackSubmissionCopyWith<$Res>  {
  factory $FeedbackSubmissionCopyWith(FeedbackSubmission value, $Res Function(FeedbackSubmission) _then) = _$FeedbackSubmissionCopyWithImpl;
@useResult
$Res call({
 String formId, String programId, String userId, List<FeedbackAnswer> answers, DateTime submittedAt
});




}
/// @nodoc
class _$FeedbackSubmissionCopyWithImpl<$Res>
    implements $FeedbackSubmissionCopyWith<$Res> {
  _$FeedbackSubmissionCopyWithImpl(this._self, this._then);

  final FeedbackSubmission _self;
  final $Res Function(FeedbackSubmission) _then;

/// Create a copy of FeedbackSubmission
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? formId = null,Object? programId = null,Object? userId = null,Object? answers = null,Object? submittedAt = null,}) {
  return _then(_self.copyWith(
formId: null == formId ? _self.formId : formId // ignore: cast_nullable_to_non_nullable
as String,programId: null == programId ? _self.programId : programId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,answers: null == answers ? _self.answers : answers // ignore: cast_nullable_to_non_nullable
as List<FeedbackAnswer>,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedbackSubmission].
extension FeedbackSubmissionPatterns on FeedbackSubmission {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedbackSubmission value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedbackSubmission() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedbackSubmission value)  $default,){
final _that = this;
switch (_that) {
case _FeedbackSubmission():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedbackSubmission value)?  $default,){
final _that = this;
switch (_that) {
case _FeedbackSubmission() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String formId,  String programId,  String userId,  List<FeedbackAnswer> answers,  DateTime submittedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedbackSubmission() when $default != null:
return $default(_that.formId,_that.programId,_that.userId,_that.answers,_that.submittedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String formId,  String programId,  String userId,  List<FeedbackAnswer> answers,  DateTime submittedAt)  $default,) {final _that = this;
switch (_that) {
case _FeedbackSubmission():
return $default(_that.formId,_that.programId,_that.userId,_that.answers,_that.submittedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String formId,  String programId,  String userId,  List<FeedbackAnswer> answers,  DateTime submittedAt)?  $default,) {final _that = this;
switch (_that) {
case _FeedbackSubmission() when $default != null:
return $default(_that.formId,_that.programId,_that.userId,_that.answers,_that.submittedAt);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _FeedbackSubmission implements FeedbackSubmission {
  const _FeedbackSubmission({required this.formId, required this.programId, required this.userId, required final  List<FeedbackAnswer> answers, required this.submittedAt}): _answers = answers;
  factory _FeedbackSubmission.fromJson(Map<String, dynamic> json) => _$FeedbackSubmissionFromJson(json);

@override final  String formId;
@override final  String programId;
@override final  String userId;
 final  List<FeedbackAnswer> _answers;
@override List<FeedbackAnswer> get answers {
  if (_answers is EqualUnmodifiableListView) return _answers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_answers);
}

@override final  DateTime submittedAt;

/// Create a copy of FeedbackSubmission
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedbackSubmissionCopyWith<_FeedbackSubmission> get copyWith => __$FeedbackSubmissionCopyWithImpl<_FeedbackSubmission>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedbackSubmissionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedbackSubmission&&(identical(other.formId, formId) || other.formId == formId)&&(identical(other.programId, programId) || other.programId == programId)&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other._answers, _answers)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,formId,programId,userId,const DeepCollectionEquality().hash(_answers),submittedAt);

@override
String toString() {
  return 'FeedbackSubmission(formId: $formId, programId: $programId, userId: $userId, answers: $answers, submittedAt: $submittedAt)';
}


}

/// @nodoc
abstract mixin class _$FeedbackSubmissionCopyWith<$Res> implements $FeedbackSubmissionCopyWith<$Res> {
  factory _$FeedbackSubmissionCopyWith(_FeedbackSubmission value, $Res Function(_FeedbackSubmission) _then) = __$FeedbackSubmissionCopyWithImpl;
@override @useResult
$Res call({
 String formId, String programId, String userId, List<FeedbackAnswer> answers, DateTime submittedAt
});




}
/// @nodoc
class __$FeedbackSubmissionCopyWithImpl<$Res>
    implements _$FeedbackSubmissionCopyWith<$Res> {
  __$FeedbackSubmissionCopyWithImpl(this._self, this._then);

  final _FeedbackSubmission _self;
  final $Res Function(_FeedbackSubmission) _then;

/// Create a copy of FeedbackSubmission
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? formId = null,Object? programId = null,Object? userId = null,Object? answers = null,Object? submittedAt = null,}) {
  return _then(_FeedbackSubmission(
formId: null == formId ? _self.formId : formId // ignore: cast_nullable_to_non_nullable
as String,programId: null == programId ? _self.programId : programId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,answers: null == answers ? _self._answers : answers // ignore: cast_nullable_to_non_nullable
as List<FeedbackAnswer>,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
