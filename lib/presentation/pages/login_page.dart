import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/presentation/pages/main_page.dart';
import 'package:xlerate/presentation/pages/register_page.dart';
import 'package:xlerate/presentation/providers/user_provider.dart';
import 'package:xlerate/core/result.dart';
import 'package:xlerate/domain/entities/user_model.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  // UI and state control variables
  bool hidePassword = true;
  bool _isLoading = false;

  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();
  final form = GlobalKey<FormState>();

  @override
  void dispose() {
    emailControl.dispose();
    passwordControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 24.0,
            ),
            child: Form(
              key: form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // --- BRANDING / LOGO HEADER ---
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/logo.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // --- EMAIL INPUT FIELD ---
                  TextFormField(
                    controller: emailControl,
                    enabled: !_isLoading,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'example@xlerate.com',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      final emailRegex = RegExp(r'^[\w.\-]+@[\w\-]+\.\w+$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // --- PASSWORD INPUT FIELD ---
                  TextFormField(
                    controller: passwordControl,
                    enabled: !_isLoading,
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // --- LOGIN SUBMIT BUTTON ---
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () async {
                              // Trigger form validation before proceeding to network call
                              if (form.currentState!.validate()) {
                                setState(() {
                                  _isLoading =
                                      true; // Turn on spinner and lock inputs
                                });

                                final email = emailControl.text.trim();
                                final password = passwordControl.text.trim();

                                // Call cloud repository method via Riverpod provider
                                final result = await ref
                                    .read(userProvider.notifier)
                                    .login(email: email, password: password);

                                // Safety check to ensure widget is still mounted after async gap
                                if (!context.mounted) return;

                                setState(() {
                                  _isLoading = false; // Turn off spinner
                                });

                                // Handle success vs failure navigation responses
                                if (result is Success<UserModel>) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MainPage(),
                                    ),
                                    (route) => false,
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text((result as Failed).message),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Login'),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --- NAVIGATION TO REGISTRATION ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      GestureDetector(
                        onTap: _isLoading
                            ? null
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterPage(),
                                  ),
                                );
                              },
                        child: const Text(
                          'Register here',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // --- DIVIDER ORNAMENT ---
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey[400])),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'or',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey[400])),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // --- ALTERNATIVE SOCIAL LOGIN BUTTON ---
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isLoading ? null : () {},
                      icon: const Icon(Icons.g_mobiledata),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      label: const Text('Login with Google'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
