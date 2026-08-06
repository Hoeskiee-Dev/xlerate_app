// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participants_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getParticipants)
final getParticipantsProvider = GetParticipantsFamily._();

final class GetParticipantsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UserModel>>,
          List<UserModel>,
          FutureOr<List<UserModel>>
        >
    with $FutureModifier<List<UserModel>>, $FutureProvider<List<UserModel>> {
  GetParticipantsProvider._({
    required GetParticipantsFamily super.from,
    required List<String> super.argument,
  }) : super(
         retry: null,
         name: r'getParticipantsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getParticipantsHash();

  @override
  String toString() {
    return r'getParticipantsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<UserModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UserModel>> create(Ref ref) {
    final argument = this.argument as List<String>;
    return getParticipants(ref, userIds: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetParticipantsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getParticipantsHash() => r'b33c4bb42375ca8ddf08117eb03ad26f95e5705b';

final class GetParticipantsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<UserModel>>, List<String>> {
  GetParticipantsFamily._()
    : super(
        retry: null,
        name: r'getParticipantsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetParticipantsProvider call({required List<String> userIds}) =>
      GetParticipantsProvider._(argument: userIds, from: this);

  @override
  String toString() => r'getParticipantsProvider';
}
