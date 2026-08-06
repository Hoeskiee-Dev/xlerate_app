// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feedback_answer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedbackAnswer {

 String get questionId; dynamic get answer;
/// Create a copy of FeedbackAnswer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedbackAnswerCopyWith<FeedbackAnswer> get copyWith => _$FeedbackAnswerCopyWithImpl<FeedbackAnswer>(this as FeedbackAnswer, _$identity);

  /// Serializes this FeedbackAnswer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedbackAnswer&&(identical(other.questionId, questionId) || other.questionId == questionId)&&const DeepCollectionEquality().equals(other.answer, answer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,questionId,const DeepCollectionEquality().hash(answer));

@override
String toString() {
  return 'FeedbackAnswer(questionId: $questionId, answer: $answer)';
}


}

/// @nodoc
abstract mixin class $FeedbackAnswerCopyWith<$Res>  {
  factory $FeedbackAnswerCopyWith(FeedbackAnswer value, $Res Function(FeedbackAnswer) _then) = _$FeedbackAnswerCopyWithImpl;
@useResult
$Res call({
 String questionId, dynamic answer
});




}
/// @nodoc
class _$FeedbackAnswerCopyWithImpl<$Res>
    implements $FeedbackAnswerCopyWith<$Res> {
  _$FeedbackAnswerCopyWithImpl(this._self, this._then);

  final FeedbackAnswer _self;
  final $Res Function(FeedbackAnswer) _then;

/// Create a copy of FeedbackAnswer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionId = null,Object? answer = freezed,}) {
  return _then(_self.copyWith(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,answer: freezed == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedbackAnswer].
extension FeedbackAnswerPatterns on FeedbackAnswer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedbackAnswer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedbackAnswer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedbackAnswer value)  $default,){
final _that = this;
switch (_that) {
case _FeedbackAnswer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedbackAnswer value)?  $default,){
final _that = this;
switch (_that) {
case _FeedbackAnswer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String questionId,  dynamic answer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedbackAnswer() when $default != null:
return $default(_that.questionId,_that.answer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String questionId,  dynamic answer)  $default,) {final _that = this;
switch (_that) {
case _FeedbackAnswer():
return $default(_that.questionId,_that.answer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String questionId,  dynamic answer)?  $default,) {final _that = this;
switch (_that) {
case _FeedbackAnswer() when $default != null:
return $default(_that.questionId,_that.answer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedbackAnswer implements FeedbackAnswer {
  const _FeedbackAnswer({required this.questionId, required this.answer});
  factory _FeedbackAnswer.fromJson(Map<String, dynamic> json) => _$FeedbackAnswerFromJson(json);

@override final  String questionId;
@override final  dynamic answer;

/// Create a copy of FeedbackAnswer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedbackAnswerCopyWith<_FeedbackAnswer> get copyWith => __$FeedbackAnswerCopyWithImpl<_FeedbackAnswer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedbackAnswerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedbackAnswer&&(identical(other.questionId, questionId) || other.questionId == questionId)&&const DeepCollectionEquality().equals(other.answer, answer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,questionId,const DeepCollectionEquality().hash(answer));

@override
String toString() {
  return 'FeedbackAnswer(questionId: $questionId, answer: $answer)';
}


}

/// @nodoc
abstract mixin class _$FeedbackAnswerCopyWith<$Res> implements $FeedbackAnswerCopyWith<$Res> {
  factory _$FeedbackAnswerCopyWith(_FeedbackAnswer value, $Res Function(_FeedbackAnswer) _then) = __$FeedbackAnswerCopyWithImpl;
@override @useResult
$Res call({
 String questionId, dynamic answer
});




}
/// @nodoc
class __$FeedbackAnswerCopyWithImpl<$Res>
    implements _$FeedbackAnswerCopyWith<$Res> {
  __$FeedbackAnswerCopyWithImpl(this._self, this._then);

  final _FeedbackAnswer _self;
  final $Res Function(_FeedbackAnswer) _then;

/// Create a copy of FeedbackAnswer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionId = null,Object? answer = freezed,}) {
  return _then(_FeedbackAnswer(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,answer: freezed == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
