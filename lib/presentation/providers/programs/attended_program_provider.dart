import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/domain/entities/program.dart';
import 'package:xlerate/presentation/providers/programs/programs_list_provider.dart';
import 'package:xlerate/presentation/providers/user_provider.dart';

final attendedProgramProvider = Provider<AsyncValue<List<Program>>>((ref) {
  final user = ref.watch(userProvider);

  if (user == null) {
    return const AsyncData([]);
  }

  final currentUserId = user.id;

  final allProgramsAsync = ref.watch(programsListProvider);

  return allProgramsAsync.whenData((programs) {
    return programs.where((program) {
      return program.joinedUserIds.contains(currentUserId);
    }).toList();
  });
});
