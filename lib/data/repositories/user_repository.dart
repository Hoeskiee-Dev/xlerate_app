import 'package:xlerate/core/result.dart';
import 'package:xlerate/domain/entities/user_model.dart';

abstract interface class UserRepository {
  Future<Result<UserModel>> getUserById(String id);
}
