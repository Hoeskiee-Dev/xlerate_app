import 'dart:convert'; // REQUIRED to decode the Base64 text back into an image
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/domain/entities/program.dart';
import 'package:xlerate/presentation/providers/user_provider.dart';
import 'package:xlerate/presentation/pages/confirmation_screen.dart';

/// A modal bottom sheet widget that prompts the user to confirm their program registration,
/// displays their live profile summary details, and routes them to the success confirmation screen.
class ApplyConfirmationSheet extends ConsumerWidget {
  // The program the user is attempting to apply for
  final Program program;

  const ApplyConfirmationSheet({super.key, required this.program});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch live user state from Riverpod provider
    final currentUser = ref.watch(userProvider);

    // 2. Extract dynamic user values with safe string fallbacks
    final String userName = currentUser?.name ?? "User Name";
    final String userEmail = currentUser?.email ?? "user@example.com";
    final String? userAvatar = currentUser?.avatar;

    // --- HELPER: Safely decodes Base64 cloud data blobs or standard remote URLs ---
    ImageProvider? _getAvatarImage() {
      if (userAvatar == null || userAvatar.isEmpty) {
        return null; // Return null so the fallback icon displays inside the CircleAvatar
      }
      if (userAvatar.length > 500) {
        // Decode massive Base64 text string back into raw memory image bytes
        return MemoryImage(base64Decode(userAvatar));
      }
      // Otherwise, treat the data string as a standard network image URL
      return NetworkImage(userAvatar);
    }

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- MODAL HEADER & CLOSE BUTTON ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Confirm Application",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context), // Dismisses modal
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 12),

            // --- TARGET PROGRAM DETAILS ---
            const Text(
              "You are applying for:",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              program.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFFFF6A3D),
              ),
            ),
            const SizedBox(height: 24),

            // --- APPLICANT PROFILE SUMMARY CARD ---
            const Text(
              "Your Profile Details:",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.blue.shade50,
                    // Load parsed profile avatar image
                    backgroundImage: _getAvatarImage(),
                    // Fallback icon if avatar data is missing
                    child: userAvatar == null || userAvatar.isEmpty
                        ? const Icon(Icons.person, color: Colors.blue)
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          userEmail,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // --- CONFIRMATION SUBMIT BUTTON ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6A3D),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // 1. Close the confirmation bottom sheet modal first
                  Navigator.pop(
                    context,
                    true,
                  );

                  // 2. Navigate to the success confirmation screen, passing the program payload
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmationScreen(
                        program: program,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Confirm & Apply",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
