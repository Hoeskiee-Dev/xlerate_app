import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/presentation/pages/register_page.dart';
import 'package:xlerate/presentation/providers/user_provider.dart';

/// A reusable widget that triggers a confirmation dialog before logging the user out,
/// clearing their session state, and returning them to the authentication flow.
class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          // Open confirmation dialog on tap
          _showLogoutDialog(context, ref);
        },
        icon: const Icon(
          Icons.logout,
          color: Colors.red,
        ),
        label: const Text(
          "Logout",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: const BorderSide(
            color: Colors.red,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  /// Displays an alert dialog confirming user logout intent.
  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text(
            "Are you sure you want to logout?",
          ),
          actions: [
            // Cancel button dismisses the dialog
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            // Confirmation logout button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // 1. Clear active user profile data from Riverpod state provider
                ref.read(userProvider.notifier).clearUser();

                // 2. Dismiss the alert dialog
                Navigator.pop(context);

                // 3. Clear navigation stack and redirect user to authentication screen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterPage(),
                  ),
                  (route) => false,
                );
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}
