import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:xlerate/data/repositories/user_repository.dart';
import 'package:xlerate/data/users/be_user_repository.dart';

part 'user_repository.g.dart';

@riverpod
UserRepository userRepository(Ref ref) => BeUserRepository();
