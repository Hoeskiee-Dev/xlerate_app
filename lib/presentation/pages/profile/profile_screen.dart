import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/activity.dart';
import 'widgets/badge_card.dart';
import 'widgets/logout_button.dart';
import 'widgets/profile_header.dart';
import 'edit_profile_screen.dart';
import 'package:xlerate/domain/entities/user_model.dart';
import 'registered_programs_screen.dart';
import 'package:xlerate/presentation/providers/user_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFFFF6B00),
          ),
        ),
      );
    }

    final int registeredCount = user.joinedPrograms?.length ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
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
            ProfileHeader(user: user),

            const SizedBox(height: 30),

            const Text(
              "Activity",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: ActivityCard(
                    number: registeredCount.toString(),
                    title: "Events Registered",
                    icon: Icons.event_available,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisteredProgramsScreen(
                            joinedPrograms: user.joinedPrograms ?? [],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: ActivityCard(
                    number: "27",
                    title: "Tasks Completed",
                    icon: Icons.task_alt,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: ActivityCard(
                    number: "4",
                    title: "Certificates",
                    icon: Icons.workspace_premium,
                  ),
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

            // --- LOGOUT BUTTON ---
            const LogoutButton(),
          ],
        ),
      ),
    );
  }
}
