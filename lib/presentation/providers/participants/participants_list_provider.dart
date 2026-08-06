// presentation/providers/programs/participants_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/core/result.dart';
import 'package:xlerate/domain/entities/user_model.dart';
import 'package:xlerate/presentation/providers/usecases/get_participants_details.dart';

part 'participants_list_provider.g.dart';

@riverpod
Future<List<UserModel>> getParticipants(
  Ref ref, {
  required List<String> userIds,
}) async {
  final useCase = ref.watch(getParticipantsDetailsProvider);

  final result = await useCase(userIds);

  return switch (result) {
    Success(value: final users) => users,
    Failed(:final message) => throw Exception(message),
  };
}
