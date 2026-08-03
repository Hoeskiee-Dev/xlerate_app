// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'joined_program.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JoinedProgram {

 String get id; String get title; String get date; String get status;
/// Create a copy of JoinedProgram
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JoinedProgramCopyWith<JoinedProgram> get copyWith => _$JoinedProgramCopyWithImpl<JoinedProgram>(this as JoinedProgram, _$identity);

  /// Serializes this JoinedProgram to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinedProgram&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,date,status);

@override
String toString() {
  return 'JoinedProgram(id: $id, title: $title, date: $date, status: $status)';
}


}

/// @nodoc
abstract mixin class $JoinedProgramCopyWith<$Res>  {
  factory $JoinedProgramCopyWith(JoinedProgram value, $Res Function(JoinedProgram) _then) = _$JoinedProgramCopyWithImpl;
@useResult
$Res call({
 String id, String title, String date, String status
});




}
/// @nodoc
class _$JoinedProgramCopyWithImpl<$Res>
    implements $JoinedProgramCopyWith<$Res> {
  _$JoinedProgramCopyWithImpl(this._self, this._then);

  final JoinedProgram _self;
  final $Res Function(JoinedProgram) _then;

/// Create a copy of JoinedProgram
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? date = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [JoinedProgram].
extension JoinedProgramPatterns on JoinedProgram {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JoinedProgram value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JoinedProgram() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JoinedProgram value)  $default,){
final _that = this;
switch (_that) {
case _JoinedProgram():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JoinedProgram value)?  $default,){
final _that = this;
switch (_that) {
case _JoinedProgram() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String date,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JoinedProgram() when $default != null:
return $default(_that.id,_that.title,_that.date,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String date,  String status)  $default,) {final _that = this;
switch (_that) {
case _JoinedProgram():
return $default(_that.id,_that.title,_that.date,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String date,  String status)?  $default,) {final _that = this;
switch (_that) {
case _JoinedProgram() when $default != null:
return $default(_that.id,_that.title,_that.date,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JoinedProgram implements JoinedProgram {
  const _JoinedProgram({required this.id, required this.title, required this.date, this.status = 'Applied'});
  factory _JoinedProgram.fromJson(Map<String, dynamic> json) => _$JoinedProgramFromJson(json);

@override final  String id;
@override final  String title;
@override final  String date;
@override@JsonKey() final  String status;

/// Create a copy of JoinedProgram
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JoinedProgramCopyWith<_JoinedProgram> get copyWith => __$JoinedProgramCopyWithImpl<_JoinedProgram>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JoinedProgramToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JoinedProgram&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,date,status);

@override
String toString() {
  return 'JoinedProgram(id: $id, title: $title, date: $date, status: $status)';
}


}

/// @nodoc
abstract mixin class _$JoinedProgramCopyWith<$Res> implements $JoinedProgramCopyWith<$Res> {
  factory _$JoinedProgramCopyWith(_JoinedProgram value, $Res Function(_JoinedProgram) _then) = __$JoinedProgramCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String date, String status
});




}
/// @nodoc
class __$JoinedProgramCopyWithImpl<$Res>
    implements _$JoinedProgramCopyWith<$Res> {
  __$JoinedProgramCopyWithImpl(this._self, this._then);

  final _JoinedProgram _self;
  final $Res Function(_JoinedProgram) _then;

/// Create a copy of JoinedProgram
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? date = null,Object? status = null,}) {
  return _then(_JoinedProgram(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
