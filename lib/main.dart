import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xlerate/domain/entities/user_model.dart';
import 'package:xlerate/presentation/pages/splash_screen.dart';
import 'package:xlerate/presentation/providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          surface: const Color(0xFFF8F9FA),
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
      home: const SplashScreen(),
    );
  }
}
