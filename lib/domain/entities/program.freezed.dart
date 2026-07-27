// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'program.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Program {

 String? get id; String get title; String get description; String get host; String? get speaker; String get startDate; String? get endDate; String get time; String get locationType; String get location; String get tag; List<String> get skills; String get eligibility; bool get isFree; double get fee; bool get offersCertificate; bool get offersBadge; bool get offersMicroScholarships; bool get offersLetterOfRecommendation; bool get offersPhysicalSwags; bool get offersXleratePoints; int? get xpAmount; String? get extraReward; String get imageUrl;@JsonKey(includeFromJson: false, includeToJson: false) File? get imageFile; int? get totalSeats; int get joinedCount; SavedFeedbackForm? get feedbackForm; String? get registrationDeadLine;
/// Create a copy of Program
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgramCopyWith<Program> get copyWith => _$ProgramCopyWithImpl<Program>(this as Program, _$identity);

  /// Serializes this Program to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Program&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.host, host) || other.host == host)&&(identical(other.speaker, speaker) || other.speaker == speaker)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.time, time) || other.time == time)&&(identical(other.locationType, locationType) || other.locationType == locationType)&&(identical(other.location, location) || other.location == location)&&(identical(other.tag, tag) || other.tag == tag)&&const DeepCollectionEquality().equals(other.skills, skills)&&(identical(other.eligibility, eligibility) || other.eligibility == eligibility)&&(identical(other.isFree, isFree) || other.isFree == isFree)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.offersCertificate, offersCertificate) || other.offersCertificate == offersCertificate)&&(identical(other.offersBadge, offersBadge) || other.offersBadge == offersBadge)&&(identical(other.offersMicroScholarships, offersMicroScholarships) || other.offersMicroScholarships == offersMicroScholarships)&&(identical(other.offersLetterOfRecommendation, offersLetterOfRecommendation) || other.offersLetterOfRecommendation == offersLetterOfRecommendation)&&(identical(other.offersPhysicalSwags, offersPhysicalSwags) || other.offersPhysicalSwags == offersPhysicalSwags)&&(identical(other.offersXleratePoints, offersXleratePoints) || other.offersXleratePoints == offersXleratePoints)&&(identical(other.xpAmount, xpAmount) || other.xpAmount == xpAmount)&&(identical(other.extraReward, extraReward) || other.extraReward == extraReward)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.imageFile, imageFile) || other.imageFile == imageFile)&&(identical(other.totalSeats, totalSeats) || other.totalSeats == totalSeats)&&(identical(other.joinedCount, joinedCount) || other.joinedCount == joinedCount)&&(identical(other.feedbackForm, feedbackForm) || other.feedbackForm == feedbackForm)&&(identical(other.registrationDeadLine, registrationDeadLine) || other.registrationDeadLine == registrationDeadLine));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,host,speaker,startDate,endDate,time,locationType,location,tag,const DeepCollectionEquality().hash(skills),eligibility,isFree,fee,offersCertificate,offersBadge,offersMicroScholarships,offersLetterOfRecommendation,offersPhysicalSwags,offersXleratePoints,xpAmount,extraReward,imageUrl,imageFile,totalSeats,joinedCount,feedbackForm,registrationDeadLine]);

@override
String toString() {
  return 'Program(id: $id, title: $title, description: $description, host: $host, speaker: $speaker, startDate: $startDate, endDate: $endDate, time: $time, locationType: $locationType, location: $location, tag: $tag, skills: $skills, eligibility: $eligibility, isFree: $isFree, fee: $fee, offersCertificate: $offersCertificate, offersBadge: $offersBadge, offersMicroScholarships: $offersMicroScholarships, offersLetterOfRecommendation: $offersLetterOfRecommendation, offersPhysicalSwags: $offersPhysicalSwags, offersXleratePoints: $offersXleratePoints, xpAmount: $xpAmount, extraReward: $extraReward, imageUrl: $imageUrl, imageFile: $imageFile, totalSeats: $totalSeats, joinedCount: $joinedCount, feedbackForm: $feedbackForm, registrationDeadLine: $registrationDeadLine)';
}


}

/// @nodoc
abstract mixin class $ProgramCopyWith<$Res>  {
  factory $ProgramCopyWith(Program value, $Res Function(Program) _then) = _$ProgramCopyWithImpl;
@useResult
$Res call({
 String? id, String title, String description, String host, String? speaker, String startDate, String? endDate, String time, String locationType, String location, String tag, List<String> skills, String eligibility, bool isFree, double fee, bool offersCertificate, bool offersBadge, bool offersMicroScholarships, bool offersLetterOfRecommendation, bool offersPhysicalSwags, bool offersXleratePoints, int? xpAmount, String? extraReward, String imageUrl,@JsonKey(includeFromJson: false, includeToJson: false) File? imageFile, int? totalSeats, int joinedCount, SavedFeedbackForm? feedbackForm, String? registrationDeadLine
});


$SavedFeedbackFormCopyWith<$Res>? get feedbackForm;

}
/// @nodoc
class _$ProgramCopyWithImpl<$Res>
    implements $ProgramCopyWith<$Res> {
  _$ProgramCopyWithImpl(this._self, this._then);

  final Program _self;
  final $Res Function(Program) _then;

/// Create a copy of Program
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = null,Object? description = null,Object? host = null,Object? speaker = freezed,Object? startDate = null,Object? endDate = freezed,Object? time = null,Object? locationType = null,Object? location = null,Object? tag = null,Object? skills = null,Object? eligibility = null,Object? isFree = null,Object? fee = null,Object? offersCertificate = null,Object? offersBadge = null,Object? offersMicroScholarships = null,Object? offersLetterOfRecommendation = null,Object? offersPhysicalSwags = null,Object? offersXleratePoints = null,Object? xpAmount = freezed,Object? extraReward = freezed,Object? imageUrl = null,Object? imageFile = freezed,Object? totalSeats = freezed,Object? joinedCount = null,Object? feedbackForm = freezed,Object? registrationDeadLine = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,host: null == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String,speaker: freezed == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,locationType: null == locationType ? _self.locationType : locationType // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,skills: null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,eligibility: null == eligibility ? _self.eligibility : eligibility // ignore: cast_nullable_to_non_nullable
as String,isFree: null == isFree ? _self.isFree : isFree // ignore: cast_nullable_to_non_nullable
as bool,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as double,offersCertificate: null == offersCertificate ? _self.offersCertificate : offersCertificate // ignore: cast_nullable_to_non_nullable
as bool,offersBadge: null == offersBadge ? _self.offersBadge : offersBadge // ignore: cast_nullable_to_non_nullable
as bool,offersMicroScholarships: null == offersMicroScholarships ? _self.offersMicroScholarships : offersMicroScholarships // ignore: cast_nullable_to_non_nullable
as bool,offersLetterOfRecommendation: null == offersLetterOfRecommendation ? _self.offersLetterOfRecommendation : offersLetterOfRecommendation // ignore: cast_nullable_to_non_nullable
as bool,offersPhysicalSwags: null == offersPhysicalSwags ? _self.offersPhysicalSwags : offersPhysicalSwags // ignore: cast_nullable_to_non_nullable
as bool,offersXleratePoints: null == offersXleratePoints ? _self.offersXleratePoints : offersXleratePoints // ignore: cast_nullable_to_non_nullable
as bool,xpAmount: freezed == xpAmount ? _self.xpAmount : xpAmount // ignore: cast_nullable_to_non_nullable
as int?,extraReward: freezed == extraReward ? _self.extraReward : extraReward // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,imageFile: freezed == imageFile ? _self.imageFile : imageFile // ignore: cast_nullable_to_non_nullable
as File?,totalSeats: freezed == totalSeats ? _self.totalSeats : totalSeats // ignore: cast_nullable_to_non_nullable
as int?,joinedCount: null == joinedCount ? _self.joinedCount : joinedCount // ignore: cast_nullable_to_non_nullable
as int,feedbackForm: freezed == feedbackForm ? _self.feedbackForm : feedbackForm // ignore: cast_nullable_to_non_nullable
as SavedFeedbackForm?,registrationDeadLine: freezed == registrationDeadLine ? _self.registrationDeadLine : registrationDeadLine // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Program
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SavedFeedbackFormCopyWith<$Res>? get feedbackForm {
    if (_self.feedbackForm == null) {
    return null;
  }

  return $SavedFeedbackFormCopyWith<$Res>(_self.feedbackForm!, (value) {
    return _then(_self.copyWith(feedbackForm: value));
  });
}
}


/// Adds pattern-matching-related methods to [Program].
extension ProgramPatterns on Program {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Program value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Program() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Program value)  $default,){
final _that = this;
switch (_that) {
case _Program():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Program value)?  $default,){
final _that = this;
switch (_that) {
case _Program() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String title,  String description,  String host,  String? speaker,  String startDate,  String? endDate,  String time,  String locationType,  String location,  String tag,  List<String> skills,  String eligibility,  bool isFree,  double fee,  bool offersCertificate,  bool offersBadge,  bool offersMicroScholarships,  bool offersLetterOfRecommendation,  bool offersPhysicalSwags,  bool offersXleratePoints,  int? xpAmount,  String? extraReward,  String imageUrl, @JsonKey(includeFromJson: false, includeToJson: false)  File? imageFile,  int? totalSeats,  int joinedCount,  SavedFeedbackForm? feedbackForm,  String? registrationDeadLine)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Program() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.host,_that.speaker,_that.startDate,_that.endDate,_that.time,_that.locationType,_that.location,_that.tag,_that.skills,_that.eligibility,_that.isFree,_that.fee,_that.offersCertificate,_that.offersBadge,_that.offersMicroScholarships,_that.offersLetterOfRecommendation,_that.offersPhysicalSwags,_that.offersXleratePoints,_that.xpAmount,_that.extraReward,_that.imageUrl,_that.imageFile,_that.totalSeats,_that.joinedCount,_that.feedbackForm,_that.registrationDeadLine);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String title,  String description,  String host,  String? speaker,  String startDate,  String? endDate,  String time,  String locationType,  String location,  String tag,  List<String> skills,  String eligibility,  bool isFree,  double fee,  bool offersCertificate,  bool offersBadge,  bool offersMicroScholarships,  bool offersLetterOfRecommendation,  bool offersPhysicalSwags,  bool offersXleratePoints,  int? xpAmount,  String? extraReward,  String imageUrl, @JsonKey(includeFromJson: false, includeToJson: false)  File? imageFile,  int? totalSeats,  int joinedCount,  SavedFeedbackForm? feedbackForm,  String? registrationDeadLine)  $default,) {final _that = this;
switch (_that) {
case _Program():
return $default(_that.id,_that.title,_that.description,_that.host,_that.speaker,_that.startDate,_that.endDate,_that.time,_that.locationType,_that.location,_that.tag,_that.skills,_that.eligibility,_that.isFree,_that.fee,_that.offersCertificate,_that.offersBadge,_that.offersMicroScholarships,_that.offersLetterOfRecommendation,_that.offersPhysicalSwags,_that.offersXleratePoints,_that.xpAmount,_that.extraReward,_that.imageUrl,_that.imageFile,_that.totalSeats,_that.joinedCount,_that.feedbackForm,_that.registrationDeadLine);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String title,  String description,  String host,  String? speaker,  String startDate,  String? endDate,  String time,  String locationType,  String location,  String tag,  List<String> skills,  String eligibility,  bool isFree,  double fee,  bool offersCertificate,  bool offersBadge,  bool offersMicroScholarships,  bool offersLetterOfRecommendation,  bool offersPhysicalSwags,  bool offersXleratePoints,  int? xpAmount,  String? extraReward,  String imageUrl, @JsonKey(includeFromJson: false, includeToJson: false)  File? imageFile,  int? totalSeats,  int joinedCount,  SavedFeedbackForm? feedbackForm,  String? registrationDeadLine)?  $default,) {final _that = this;
switch (_that) {
case _Program() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.host,_that.speaker,_that.startDate,_that.endDate,_that.time,_that.locationType,_that.location,_that.tag,_that.skills,_that.eligibility,_that.isFree,_that.fee,_that.offersCertificate,_that.offersBadge,_that.offersMicroScholarships,_that.offersLetterOfRecommendation,_that.offersPhysicalSwags,_that.offersXleratePoints,_that.xpAmount,_that.extraReward,_that.imageUrl,_that.imageFile,_that.totalSeats,_that.joinedCount,_that.feedbackForm,_that.registrationDeadLine);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _Program implements Program {
  const _Program({this.id, required this.title, required this.description, required this.host, this.speaker, required this.startDate, this.endDate, required this.time, required this.locationType, required this.location, required this.tag, required final  List<String> skills, required this.eligibility, required this.isFree, required this.fee, required this.offersCertificate, required this.offersBadge, required this.offersMicroScholarships, required this.offersLetterOfRecommendation, required this.offersPhysicalSwags, required this.offersXleratePoints, this.xpAmount, required this.extraReward, required this.imageUrl, @JsonKey(includeFromJson: false, includeToJson: false) this.imageFile, this.totalSeats, required this.joinedCount, this.feedbackForm, this.registrationDeadLine}): _skills = skills;
  factory _Program.fromJson(Map<String, dynamic> json) => _$ProgramFromJson(json);

@override final  String? id;
@override final  String title;
@override final  String description;
@override final  String host;
@override final  String? speaker;
@override final  String startDate;
@override final  String? endDate;
@override final  String time;
@override final  String locationType;
@override final  String location;
@override final  String tag;
 final  List<String> _skills;
@override List<String> get skills {
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skills);
}

@override final  String eligibility;
@override final  bool isFree;
@override final  double fee;
@override final  bool offersCertificate;
@override final  bool offersBadge;
@override final  bool offersMicroScholarships;
@override final  bool offersLetterOfRecommendation;
@override final  bool offersPhysicalSwags;
@override final  bool offersXleratePoints;
@override final  int? xpAmount;
@override final  String? extraReward;
@override final  String imageUrl;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  File? imageFile;
@override final  int? totalSeats;
@override final  int joinedCount;
@override final  SavedFeedbackForm? feedbackForm;
@override final  String? registrationDeadLine;

/// Create a copy of Program
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgramCopyWith<_Program> get copyWith => __$ProgramCopyWithImpl<_Program>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProgramToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Program&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.host, host) || other.host == host)&&(identical(other.speaker, speaker) || other.speaker == speaker)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.time, time) || other.time == time)&&(identical(other.locationType, locationType) || other.locationType == locationType)&&(identical(other.location, location) || other.location == location)&&(identical(other.tag, tag) || other.tag == tag)&&const DeepCollectionEquality().equals(other._skills, _skills)&&(identical(other.eligibility, eligibility) || other.eligibility == eligibility)&&(identical(other.isFree, isFree) || other.isFree == isFree)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.offersCertificate, offersCertificate) || other.offersCertificate == offersCertificate)&&(identical(other.offersBadge, offersBadge) || other.offersBadge == offersBadge)&&(identical(other.offersMicroScholarships, offersMicroScholarships) || other.offersMicroScholarships == offersMicroScholarships)&&(identical(other.offersLetterOfRecommendation, offersLetterOfRecommendation) || other.offersLetterOfRecommendation == offersLetterOfRecommendation)&&(identical(other.offersPhysicalSwags, offersPhysicalSwags) || other.offersPhysicalSwags == offersPhysicalSwags)&&(identical(other.offersXleratePoints, offersXleratePoints) || other.offersXleratePoints == offersXleratePoints)&&(identical(other.xpAmount, xpAmount) || other.xpAmount == xpAmount)&&(identical(other.extraReward, extraReward) || other.extraReward == extraReward)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.imageFile, imageFile) || other.imageFile == imageFile)&&(identical(other.totalSeats, totalSeats) || other.totalSeats == totalSeats)&&(identical(other.joinedCount, joinedCount) || other.joinedCount == joinedCount)&&(identical(other.feedbackForm, feedbackForm) || other.feedbackForm == feedbackForm)&&(identical(other.registrationDeadLine, registrationDeadLine) || other.registrationDeadLine == registrationDeadLine));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,host,speaker,startDate,endDate,time,locationType,location,tag,const DeepCollectionEquality().hash(_skills),eligibility,isFree,fee,offersCertificate,offersBadge,offersMicroScholarships,offersLetterOfRecommendation,offersPhysicalSwags,offersXleratePoints,xpAmount,extraReward,imageUrl,imageFile,totalSeats,joinedCount,feedbackForm,registrationDeadLine]);

@override
String toString() {
  return 'Program(id: $id, title: $title, description: $description, host: $host, speaker: $speaker, startDate: $startDate, endDate: $endDate, time: $time, locationType: $locationType, location: $location, tag: $tag, skills: $skills, eligibility: $eligibility, isFree: $isFree, fee: $fee, offersCertificate: $offersCertificate, offersBadge: $offersBadge, offersMicroScholarships: $offersMicroScholarships, offersLetterOfRecommendation: $offersLetterOfRecommendation, offersPhysicalSwags: $offersPhysicalSwags, offersXleratePoints: $offersXleratePoints, xpAmount: $xpAmount, extraReward: $extraReward, imageUrl: $imageUrl, imageFile: $imageFile, totalSeats: $totalSeats, joinedCount: $joinedCount, feedbackForm: $feedbackForm, registrationDeadLine: $registrationDeadLine)';
}


}

/// @nodoc
abstract mixin class _$ProgramCopyWith<$Res> implements $ProgramCopyWith<$Res> {
  factory _$ProgramCopyWith(_Program value, $Res Function(_Program) _then) = __$ProgramCopyWithImpl;
@override @useResult
$Res call({
 String? id, String title, String description, String host, String? speaker, String startDate, String? endDate, String time, String locationType, String location, String tag, List<String> skills, String eligibility, bool isFree, double fee, bool offersCertificate, bool offersBadge, bool offersMicroScholarships, bool offersLetterOfRecommendation, bool offersPhysicalSwags, bool offersXleratePoints, int? xpAmount, String? extraReward, String imageUrl,@JsonKey(includeFromJson: false, includeToJson: false) File? imageFile, int? totalSeats, int joinedCount, SavedFeedbackForm? feedbackForm, String? registrationDeadLine
});


@override $SavedFeedbackFormCopyWith<$Res>? get feedbackForm;

}
/// @nodoc
class __$ProgramCopyWithImpl<$Res>
    implements _$ProgramCopyWith<$Res> {
  __$ProgramCopyWithImpl(this._self, this._then);

  final _Program _self;
  final $Res Function(_Program) _then;

/// Create a copy of Program
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = null,Object? description = null,Object? host = null,Object? speaker = freezed,Object? startDate = null,Object? endDate = freezed,Object? time = null,Object? locationType = null,Object? location = null,Object? tag = null,Object? skills = null,Object? eligibility = null,Object? isFree = null,Object? fee = null,Object? offersCertificate = null,Object? offersBadge = null,Object? offersMicroScholarships = null,Object? offersLetterOfRecommendation = null,Object? offersPhysicalSwags = null,Object? offersXleratePoints = null,Object? xpAmount = freezed,Object? extraReward = freezed,Object? imageUrl = null,Object? imageFile = freezed,Object? totalSeats = freezed,Object? joinedCount = null,Object? feedbackForm = freezed,Object? registrationDeadLine = freezed,}) {
  return _then(_Program(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,host: null == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String,speaker: freezed == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,locationType: null == locationType ? _self.locationType : locationType // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,skills: null == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,eligibility: null == eligibility ? _self.eligibility : eligibility // ignore: cast_nullable_to_non_nullable
as String,isFree: null == isFree ? _self.isFree : isFree // ignore: cast_nullable_to_non_nullable
as bool,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as double,offersCertificate: null == offersCertificate ? _self.offersCertificate : offersCertificate // ignore: cast_nullable_to_non_nullable
as bool,offersBadge: null == offersBadge ? _self.offersBadge : offersBadge // ignore: cast_nullable_to_non_nullable
as bool,offersMicroScholarships: null == offersMicroScholarships ? _self.offersMicroScholarships : offersMicroScholarships // ignore: cast_nullable_to_non_nullable
as bool,offersLetterOfRecommendation: null == offersLetterOfRecommendation ? _self.offersLetterOfRecommendation : offersLetterOfRecommendation // ignore: cast_nullable_to_non_nullable
as bool,offersPhysicalSwags: null == offersPhysicalSwags ? _self.offersPhysicalSwags : offersPhysicalSwags // ignore: cast_nullable_to_non_nullable
as bool,offersXleratePoints: null == offersXleratePoints ? _self.offersXleratePoints : offersXleratePoints // ignore: cast_nullable_to_non_nullable
as bool,xpAmount: freezed == xpAmount ? _self.xpAmount : xpAmount // ignore: cast_nullable_to_non_nullable
as int?,extraReward: freezed == extraReward ? _self.extraReward : extraReward // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,imageFile: freezed == imageFile ? _self.imageFile : imageFile // ignore: cast_nullable_to_non_nullable
as File?,totalSeats: freezed == totalSeats ? _self.totalSeats : totalSeats // ignore: cast_nullable_to_non_nullable
as int?,joinedCount: null == joinedCount ? _self.joinedCount : joinedCount // ignore: cast_nullable_to_non_nullable
as int,feedbackForm: freezed == feedbackForm ? _self.feedbackForm : feedbackForm // ignore: cast_nullable_to_non_nullable
as SavedFeedbackForm?,registrationDeadLine: freezed == registrationDeadLine ? _self.registrationDeadLine : registrationDeadLine // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Program
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SavedFeedbackFormCopyWith<$Res>? get feedbackForm {
    if (_self.feedbackForm == null) {
    return null;
  }

  return $SavedFeedbackFormCopyWith<$Res>(_self.feedbackForm!, (value) {
    return _then(_self.copyWith(feedbackForm: value));
  });
}
}

// dart format on
