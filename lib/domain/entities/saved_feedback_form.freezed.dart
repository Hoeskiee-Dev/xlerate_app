// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_feedback_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SavedFeedbackForm {

 String get id; String get title; String get description; List<SavedQuestion> get questions;
/// Create a copy of SavedFeedbackForm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedFeedbackFormCopyWith<SavedFeedbackForm> get copyWith => _$SavedFeedbackFormCopyWithImpl<SavedFeedbackForm>(this as SavedFeedbackForm, _$identity);

  /// Serializes this SavedFeedbackForm to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedFeedbackForm&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.questions, questions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,const DeepCollectionEquality().hash(questions));

@override
String toString() {
  return 'SavedFeedbackForm(id: $id, title: $title, description: $description, questions: $questions)';
}


}

/// @nodoc
abstract mixin class $SavedFeedbackFormCopyWith<$Res>  {
  factory $SavedFeedbackFormCopyWith(SavedFeedbackForm value, $Res Function(SavedFeedbackForm) _then) = _$SavedFeedbackFormCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, List<SavedQuestion> questions
});




}
/// @nodoc
class _$SavedFeedbackFormCopyWithImpl<$Res>
    implements $SavedFeedbackFormCopyWith<$Res> {
  _$SavedFeedbackFormCopyWithImpl(this._self, this._then);

  final SavedFeedbackForm _self;
  final $Res Function(SavedFeedbackForm) _then;

/// Create a copy of SavedFeedbackForm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? questions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<SavedQuestion>,
  ));
}

}


/// Adds pattern-matching-related methods to [SavedFeedbackForm].
extension SavedFeedbackFormPatterns on SavedFeedbackForm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedFeedbackForm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedFeedbackForm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedFeedbackForm value)  $default,){
final _that = this;
switch (_that) {
case _SavedFeedbackForm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedFeedbackForm value)?  $default,){
final _that = this;
switch (_that) {
case _SavedFeedbackForm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  List<SavedQuestion> questions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedFeedbackForm() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.questions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  List<SavedQuestion> questions)  $default,) {final _that = this;
switch (_that) {
case _SavedFeedbackForm():
return $default(_that.id,_that.title,_that.description,_that.questions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  List<SavedQuestion> questions)?  $default,) {final _that = this;
switch (_that) {
case _SavedFeedbackForm() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.questions);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SavedFeedbackForm implements SavedFeedbackForm {
  const _SavedFeedbackForm({required this.id, required this.title, required this.description, required final  List<SavedQuestion> questions}): _questions = questions;
  factory _SavedFeedbackForm.fromJson(Map<String, dynamic> json) => _$SavedFeedbackFormFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
 final  List<SavedQuestion> _questions;
@override List<SavedQuestion> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}


/// Create a copy of SavedFeedbackForm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedFeedbackFormCopyWith<_SavedFeedbackForm> get copyWith => __$SavedFeedbackFormCopyWithImpl<_SavedFeedbackForm>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavedFeedbackFormToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedFeedbackForm&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._questions, _questions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,const DeepCollectionEquality().hash(_questions));

@override
String toString() {
  return 'SavedFeedbackForm(id: $id, title: $title, description: $description, questions: $questions)';
}


}

/// @nodoc
abstract mixin class _$SavedFeedbackFormCopyWith<$Res> implements $SavedFeedbackFormCopyWith<$Res> {
  factory _$SavedFeedbackFormCopyWith(_SavedFeedbackForm value, $Res Function(_SavedFeedbackForm) _then) = __$SavedFeedbackFormCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, List<SavedQuestion> questions
});




}
/// @nodoc
class __$SavedFeedbackFormCopyWithImpl<$Res>
    implements _$SavedFeedbackFormCopyWith<$Res> {
  __$SavedFeedbackFormCopyWithImpl(this._self, this._then);

  final _SavedFeedbackForm _self;
  final $Res Function(_SavedFeedbackForm) _then;

/// Create a copy of SavedFeedbackForm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? questions = null,}) {
  return _then(_SavedFeedbackForm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<SavedQuestion>,
  ));
}


}

// dart format on
