import 'package:xlerate/core/result.dart';
import 'package:xlerate/core/usecase.dart';
import 'package:xlerate/data/repositories/user_repository.dart';
import 'package:xlerate/domain/entities/user_model.dart';

class GetParticipantsDetails
    implements UseCase<Result<List<UserModel>>, List<String>> {
  final UserRepository _userRepository;

  GetParticipantsDetails({required UserRepository userRepository})
    : _userRepository = userRepository;

  @override
  Future<Result<List<UserModel>>> call(List<String> params) async {
    if (params.isEmpty) {
      return Result.success([]);
    }

    try {
      final results = await Future.wait(
        params.map((id) => _userRepository.getUserById(id)),
      );

      final List<UserModel> users = [];

      for (final result in results) {
        switch (result) {
          case Success(value: final user):
            users.add(user);
          case Failed(:final message):
            return Result.failed(message);
        }
      }

      return Result.success(users);
    } catch (e) {
      return Result.failed("Failed to fetch participants: ${e.toString()}");
    }
  }
}
