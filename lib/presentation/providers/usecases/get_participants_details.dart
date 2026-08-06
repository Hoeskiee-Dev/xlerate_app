import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xlerate/domain/usecases/get_participants_details/get_participants_details.dart';
import 'package:xlerate/presentation/providers/repositories/user_repository.dart/user_repository.dart';

part 'get_participants_details.g.dart';

@riverpod
GetParticipantsDetails getParticipantsDetails(Ref ref) =>
    GetParticipantsDetails(userRepository: ref.watch(userRepositoryProvider));
