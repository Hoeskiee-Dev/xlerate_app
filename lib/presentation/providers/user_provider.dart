import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xlerate/data/mock_user_repository.dart';
import 'package:xlerate/domain/entities/user_model.dart';
import 'package:xlerate/core/result.dart';

/// StateNotifier provider managing authentication state, cloud synchronization,
/// and local session persistence using SharedPreferences and Riverpod.
class UserNotifier extends StateNotifier<UserModel?> {
  final MockUserRepository _userRepository;

  UserNotifier() : _userRepository = MockUserRepository(), super(null) {
    // Automatically load any previously cached session on initialization
    _loadStoredSession();
  }

  // --- HELPERS FOR LOCAL SESSION STORAGE ---

  /// Loads stored user session JSON from device local storage.
  Future<void> _loadStoredSession() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedUser = prefs.getString('logged_user_session');
    if (encodedUser != null) {
      state = UserModel.fromJson(json.decode(encodedUser));
    }
  }

  /// Persists current user session state locally or clears it on logout.
  Future<void> _persistSession() async {
    final prefs = await SharedPreferences.getInstance();
    if (state != null) {
      prefs.setString('logged_user_session', json.encode(state!.toJson()));
    } else {
      prefs.remove('logged_user_session');
    }
  }

  // --- PUBLIC ACTIONS TO INTERACT WITH THE CLOUD REPOSITORY ---

  /// Registers a new user account, updates state, and persists the session.
  Future<Result<UserModel>> registerAccount({
    required String name,
    required String email,
    required String password,
    String? dob,
  }) async {
    final tempUser = UserModel(
      id: '',
      name: name,
      email: email,
      role: 'Learner', // Default role assignment
      dob: dob,
      avatar:
          'https://i.pravatar.cc/150?u=${email.hashCode}', // Auto-generated fallback avatar
    );

    final result = await _userRepository.registerUser(
      user: tempUser,
      password: password,
    );

    if (result is Success<UserModel>) {
      state = result.value;
      await _persistSession();
      return result;
    } else {
      return Result.failed((result as Failed).message);
    }
  }

  /// Authenticates user credentials against the cloud repository.
  Future<Result<UserModel>> login({
    required String email,
    required String password,
  }) async {
    final result = await _userRepository.login(
      email: email,
      password: password,
    );

    if (result is Success<UserModel>) {
      state = result.value;
      await _persistSession();
      return result;
    } else {
      return Result.failed((result as Failed).message);
    }
  }

  /// Updates profile details with optimistic local UI updates and automatic rollback on failure.
  Future<void> updateProfile({
    String? name,
    String? email,
    String? avatar,
    String? dob,
  }) async {
    if (state == null) return;

    // 1. Save state backup in case the network sync fails
    final previousState = state;

    final updatedUser = UserModel(
      id: state!.id,
      name: name ?? state!.name,
      email: email ?? state!.email,
      role: state!.role,
      avatar: avatar ?? state!.avatar,
      dob: dob ?? state!.dob,
    );

    // 2. Optimistically update local state and storage instantly for zero-lag UI feedback
    state = updatedUser;
    await _persistSession();

    // 3. Dispatch update request to MockAPI cloud repository
    final result = await _userRepository.updateProfile(updatedUser);

    if (result is Success<UserModel>) {
      // Sync successful: lock in state with exact server response data
      state = result.value;
      await _persistSession();
    } else {
      // 4. Rollback: Revert state back to previous backup if network call fails
      state = previousState;
      await _persistSession();
    }
  }

  /// Clears active user session data and removes cached local preferences.
  void clearUser() {
    state = null;
    _persistSession();
  }
}

/// Global Riverpod state provider exposing [UserNotifier] across the application tree.
final userProvider = StateNotifierProvider<UserNotifier, UserModel?>((ref) {
  return UserNotifier();
});
