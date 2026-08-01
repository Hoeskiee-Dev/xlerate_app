import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/activity.dart';
import 'widgets/badge_card.dart';
import 'widgets/logout_button.dart';
import 'widgets/profile_header.dart';
import 'edit_profile_screen.dart';
import 'package:xlerate/domain/entities/user_model.dart';
import 'package:xlerate/presentation/providers/user_provider.dart';

/// Screen displaying the user's profile overview, user metrics (events, courses, tasks),
/// earned badges and certificates, and navigation shortcuts to edit profile or log out.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch active user state from Riverpod, providing fallback guest details if null
    final user =
        ref.watch(userProvider) ??
        const UserModel(
          id: "1",
          name: "Budi",
          email: "example@mail.com",
          role: "Learner",
          avatar: null, // Fallback default avatar property
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          // Edit Profile Navigation Shortcut
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            },
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- USER PROFILE HEADER COMPONENT ---
            ProfileHeader(user: user),

            const SizedBox(height: 30),

            // --- ACTIVITY SECTION TITLE ---
            const Text(
              "Activity",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // --- ACTIVITY METRICS GRID ---
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                ActivityCard(
                  number: "12",
                  title: "Events Attended",
                  icon: Icons.event,
                ),
                ActivityCard(
                  number: "9",
                  title: "Completed Courses",
                  icon: Icons.school,
                ),
                ActivityCard(
                  number: "27",
                  title: "Tasks Completed",
                  icon: Icons.task_alt,
                ),
                ActivityCard(
                  number: "4",
                  title: "Certificates",
                  icon: Icons.workspace_premium,
                ),
              ],
            ),

            const SizedBox(height: 30),

            // --- BADGES & CERTIFICATES HEADER ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Badges & Certificates",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Implement navigation to full badges archive screen
                  },
                  child: const Text("View All"),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // --- FEATURED BADGE CARDS ROW ---
            const Row(
              children: [
                Expanded(
                  child: BadgeCard(
                    title: "UI/UX Design",
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: BadgeCard(
                    title: "Mastering Database",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // --- LOGOUT ACTION BUTTON ---
            const LogoutButton(),
          ],
        ),
      ),
    );
  }
}
