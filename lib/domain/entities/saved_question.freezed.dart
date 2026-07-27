// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SavedQuestion {

 QuestionType get type; String get title; List<String> get options; bool get isRequired;
/// Create a copy of SavedQuestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedQuestionCopyWith<SavedQuestion> get copyWith => _$SavedQuestionCopyWithImpl<SavedQuestion>(this as SavedQuestion, _$identity);

  /// Serializes this SavedQuestion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedQuestion&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,const DeepCollectionEquality().hash(options),isRequired);

@override
String toString() {
  return 'SavedQuestion(type: $type, title: $title, options: $options, isRequired: $isRequired)';
}


}

/// @nodoc
abstract mixin class $SavedQuestionCopyWith<$Res>  {
  factory $SavedQuestionCopyWith(SavedQuestion value, $Res Function(SavedQuestion) _then) = _$SavedQuestionCopyWithImpl;
@useResult
$Res call({
 QuestionType type, String title, List<String> options, bool isRequired
});




}
/// @nodoc
class _$SavedQuestionCopyWithImpl<$Res>
    implements $SavedQuestionCopyWith<$Res> {
  _$SavedQuestionCopyWithImpl(this._self, this._then);

  final SavedQuestion _self;
  final $Res Function(SavedQuestion) _then;

/// Create a copy of SavedQuestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? title = null,Object? options = null,Object? isRequired = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuestionType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SavedQuestion].
extension SavedQuestionPatterns on SavedQuestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedQuestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedQuestion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedQuestion value)  $default,){
final _that = this;
switch (_that) {
case _SavedQuestion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedQuestion value)?  $default,){
final _that = this;
switch (_that) {
case _SavedQuestion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( QuestionType type,  String title,  List<String> options,  bool isRequired)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedQuestion() when $default != null:
return $default(_that.type,_that.title,_that.options,_that.isRequired);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( QuestionType type,  String title,  List<String> options,  bool isRequired)  $default,) {final _that = this;
switch (_that) {
case _SavedQuestion():
return $default(_that.type,_that.title,_that.options,_that.isRequired);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( QuestionType type,  String title,  List<String> options,  bool isRequired)?  $default,) {final _that = this;
switch (_that) {
case _SavedQuestion() when $default != null:
return $default(_that.type,_that.title,_that.options,_that.isRequired);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SavedQuestion implements SavedQuestion {
  const _SavedQuestion({required this.type, required this.title, required final  List<String> options, required this.isRequired}): _options = options;
  factory _SavedQuestion.fromJson(Map<String, dynamic> json) => _$SavedQuestionFromJson(json);

@override final  QuestionType type;
@override final  String title;
 final  List<String> _options;
@override List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override final  bool isRequired;

/// Create a copy of SavedQuestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedQuestionCopyWith<_SavedQuestion> get copyWith => __$SavedQuestionCopyWithImpl<_SavedQuestion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavedQuestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedQuestion&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,const DeepCollectionEquality().hash(_options),isRequired);

@override
String toString() {
  return 'SavedQuestion(type: $type, title: $title, options: $options, isRequired: $isRequired)';
}


}

/// @nodoc
abstract mixin class _$SavedQuestionCopyWith<$Res> implements $SavedQuestionCopyWith<$Res> {
  factory _$SavedQuestionCopyWith(_SavedQuestion value, $Res Function(_SavedQuestion) _then) = __$SavedQuestionCopyWithImpl;
@override @useResult
$Res call({
 QuestionType type, String title, List<String> options, bool isRequired
});




}
/// @nodoc
class __$SavedQuestionCopyWithImpl<$Res>
    implements _$SavedQuestionCopyWith<$Res> {
  __$SavedQuestionCopyWithImpl(this._self, this._then);

  final _SavedQuestion _self;
  final $Res Function(_SavedQuestion) _then;

/// Create a copy of SavedQuestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? title = null,Object? options = null,Object? isRequired = null,}) {
  return _then(_SavedQuestion(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuestionType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
