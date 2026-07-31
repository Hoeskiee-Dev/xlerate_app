import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/core/result.dart';
import 'package:xlerate/domain/entities/user_model.dart';
import 'package:xlerate/presentation/pages/main_page.dart';
import 'package:xlerate/presentation/pages/login_page.dart';
import 'package:xlerate/presentation/providers/user_provider.dart';

/// Screen responsible for handling new user registration, capturing profile details
/// (name, date of birth, email, password), validating inputs, and syncing to MockAPI.
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  // Password visibility toggles and network loading tracker
  bool obscure = true;
  bool confirmObscure = true;
  bool _isLoading = false;

  // Form input text controllers
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    nameController.dispose();
    dobController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  /// Opens a native date picker dialog and formats the selected date string.
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final List<String> months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ];
      final String formattedDate =
          "${picked.day} ${months[picked.month - 1]} ${picked.year}";
      setState(() {
        dobController.text = formattedDate;
      });
    }
  }

  /// Helper factory to build uniform, styled input decorations across all form fields.
  InputDecoration _buildDecoration(
    String label,
    String hint, {
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label.isEmpty ? null : label,
      hintText: hint,
      labelStyle: const TextStyle(
        color: Color(0xFFB8C1CF),
        fontWeight: FontWeight.w600,
      ),
      hintStyle: const TextStyle(color: Color(0xFFB8C1CF), fontSize: 16),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFB8C1CF), width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFB8C1CF), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 2),
      ),
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              // --- HEADER TITLE ---
              const Text(
                "Register\nfor the best experience.",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF344054),
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 28),

              // --- AVATAR ICON PLACEHOLDER ---
              Center(
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE6EAF0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 34,
                    color: Color(0xFF9AA5B5),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // --- NAME FIELD ---
              const Text(
                "Name",
                style: TextStyle(
                  color: Color(0xFFC1CAD8),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: nameController,
                decoration: _buildDecoration("", "Your Full Name"),
              ),
              const SizedBox(height: 14),

              // --- DATE OF BIRTH FIELD ---
              const Text(
                "Date of Birth",
                style: TextStyle(
                  color: Color(0xFFC1CAD8),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: dobController,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: _buildDecoration(
                  "",
                  "DD Month YYYY",
                  suffix: IconButton(
                    icon: const Icon(
                      Icons.calendar_month_outlined,
                      color: Color(0xFFAAB3C2),
                    ),
                    onPressed: () => _selectDate(context),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // --- EMAIL FIELD ---
              const Text(
                "Email",
                style: TextStyle(
                  color: Color(0xFFC1CAD8),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: emailController,
                decoration: _buildDecoration("", "example@gmail.com"),
              ),
              const SizedBox(height: 14),

              // --- PASSWORD FIELD ---
              const Text(
                "Password",
                style: TextStyle(
                  color: Color(0xFFC1CAD8),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: passwordController,
                obscureText: obscure,
                decoration: _buildDecoration(
                  "",
                  "Create a strong password",
                  suffix: IconButton(
                    icon: Icon(
                      obscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xFFAAB3C2),
                    ),
                    onPressed: () => setState(() => obscure = !obscure),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // --- CONFIRM PASSWORD FIELD ---
              const Text(
                "Confirm Password",
                style: TextStyle(
                  color: Color(0xFFC1CAD8),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: confirmPasswordController,
                obscureText: confirmObscure,
                decoration: _buildDecoration(
                  "",
                  "Re-enter password",
                  suffix: IconButton(
                    icon: Icon(
                      confirmObscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xFFAAB3C2),
                    ),
                    onPressed: () =>
                        setState(() => confirmObscure = !confirmObscure),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // --- REGISTER SUBMIT BUTTON WITH LOADING STATE & ERROR CATCHING ---
              SizedBox(
                height: 62,
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null // Disables button while loading to prevent duplicate requests
                      : () async {
                          setState(() => _isLoading = true);

                          try {
                            final name = nameController.text.trim();
                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();
                            final confirmPassword = confirmPasswordController
                                .text
                                .trim();
                            final dob = dobController.text.trim();

                            // 1. Validate empty fields
                            if (name.isEmpty ||
                                email.isEmpty ||
                                password.isEmpty ||
                                confirmPassword.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please fill in all required fields',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            // 2. Validate minimum password length
                            if (password.length < 6) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Password must be at least 6 characters long!',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            // 3. Validate password matching
                            if (password != confirmPassword) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Passwords do not match!'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            // 4. Dispatch registration request to cloud repository via Riverpod
                            final result = await ref
                                .read(userProvider.notifier)
                                .registerAccount(
                                  name: name,
                                  email: email,
                                  password: password,
                                  dob: dob,
                                );

                            if (!context.mounted) return;

                            // 5. Handle registration success or failure response
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
                          } catch (e) {
                            // 6. Catch unhandled runtime network or system exceptions
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('System Error: $e'),
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 4),
                              ),
                            );
                          } finally {
                            if (context.mounted) {
                              setState(() => _isLoading = false);
                            }
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6F63F6),
                    disabledBackgroundColor: const Color(
                      0xFF6F63F6,
                    ).withOpacity(0.7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 28,
                          width: 28,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : const Text(
                          "Register Now",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 14),

              // --- NAVIGATION TO LOGIN ---
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 18, color: Color(0xFF374151)),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Login here",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF3B82F6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
