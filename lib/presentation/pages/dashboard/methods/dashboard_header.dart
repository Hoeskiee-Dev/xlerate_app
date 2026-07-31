import 'dart:convert'; // Required for base64Decode
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/presentation/misc/methods.dart';
import 'package:xlerate/presentation/pages/profile/profile_screen.dart';
import 'package:xlerate/presentation/providers/user_provider.dart';

/// Renders a dynamic header widget for the dashboard displaying a time-based
/// greeting, user avatar thumbnail with image fallback, and quick navigation actions.
Widget dashboardHeader(BuildContext context) {
  // --- TIME-BASED GREETING LOGIC ---
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning!";
    } else if (hour < 17) {
      return "Good Afternoon!";
    } else {
      return "Good Evening!";
    }
  }

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Consumer(
      builder: (context, ref, child) {
        // Watch live user profile state from Riverpod
        final user = ref.watch(userProvider);

        // Safely extract first name from the user's full name (fallback to "Learner")
        final firstName = user?.name.trim().isNotEmpty == true
            ? user!.name.trim().split(' ').first
            : "Learner";

        final greeting = getGreeting();
        final avatarUrl = user?.avatar;

        // --- HELPER: Safely decodes Base64 cloud data or standard image URLs ---
        ImageProvider? getAvatarImage() {
          if (avatarUrl == null || avatarUrl.isEmpty) return null;

          if (avatarUrl.length > 500) {
            // Decode large Base64 string back into raw memory image bytes
            return MemoryImage(base64Decode(avatarUrl));
          }

          // Fallback for standard remote network image URLs
          return NetworkImage(avatarUrl);
        }

        return Row(
          children: [
            // --- USER AVATAR & PROFILE NAVIGATION ---
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 36,
                backgroundColor: Colors.blue.shade100,
                backgroundImage: getAvatarImage(),
                child: avatarUrl == null || avatarUrl.isEmpty
                    ? const Icon(Icons.person, size: 36, color: Colors.blue)
                    : null,
              ),
            ),

            horizontalSpaces(16),

            // --- GREETING AND USER NAME ---
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greeting,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    firstName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF344054),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // --- NOTIFICATION BUTTON ---
            IconButton(
              onPressed: () {
                // TODO: Implement navigation to Notification Page
              },
              icon: const Icon(
                Icons.notifications,
                size: 36,
              ),
            ),
          ],
        );
      },
    ),
  );
}
