import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xlerate/domain/entities/user_model.dart';
import 'package:xlerate/presentation/providers/user_provider.dart';
import 'package:xlerate/presentation/pages/main_page.dart'; // <-- Make sure this points to your actual main_page.dart path
import 'package:xlerate/presentation/pages/login_page.dart';
import 'package:xlerate/presentation/pages/feedback/feedback_page.dart';
import 'package:xlerate/presentation/pages/profile/profile_screen.dart';
import 'package:xlerate/presentation/pages/program/participants/participants_screen.dart';
import 'package:xlerate/presentation/pages/program/program_detail/program_detail_page.dart';
import 'package:xlerate/presentation/pages/program/program_list/program_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Read local storage on cold start before app boots
  final prefs = await SharedPreferences.getInstance();
  final encodedUser = prefs.getString('logged_user_session');

  UserModel? initialUser;
  if (encodedUser != null) {
    try {
      initialUser = UserModel.fromJson(json.decode(encodedUser));
    } catch (e) {
      initialUser = null;
    }
  }

  runApp(
    ProviderScope(
      // 2. Override the user provider with the pre-loaded local session
      overrides: [
        userProvider.overrideWith((ref) {
          final notifier = UserNotifier();
          if (initialUser != null) {
            notifier.state = initialUser;
          }
          return notifier;
        }),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(
          0xFFF8F9FA,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          surface: const Color(
            0xFFF8F9FA,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF8F9FA),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Xlerate',
      // Dynamically routes based on whether an active session is saved
      home: Consumer(
        builder: (context, ref, child) {
          final user = ref.watch(userProvider);
          return user != null ? const MainPage() : const LoginPage();
        },
      ),
    );
  }
}
