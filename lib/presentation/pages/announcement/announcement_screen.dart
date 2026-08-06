import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:xlerate/presentation/providers/user_provider.dart';
import 'package:xlerate/presentation/providers/announcement_provider.dart';
import 'package:xlerate/domain/entities/announcement.dart';
import 'create_announcement_screen.dart';
import 'dart:convert';

class AnnouncementScreen extends ConsumerWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final isAdmin = user?.role.toLowerCase() == 'admin';

    final announcementsAsyncValue = ref.watch(announcementListProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Announcement List",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 20,
                color: Colors.black54,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        actions: [
          if (isAdmin)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, size: 20, color: Colors.black54),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateAnnouncementScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
          const SizedBox(width: 8),
        ],
      ),

      body: announcementsAsyncValue.when(
        data: (announcements) {
          if (announcements.isEmpty) {
            return const Center(
              child: Text(
                "No announcements yet.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          // Reverse the list so the newest announcements show at the top!
          final reversedList = announcements.reversed.toList();

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            itemCount: reversedList.length,
            itemBuilder: (context, index) {
              return AnnouncementCard(announcement: reversedList[index]);
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xff635BFF)),
        ),
        error: (error, stackTrace) => Center(
          child: Text(
            "Failed to load announcements.\n$error",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;

  const AnnouncementCard({
    super.key,
    required this.announcement,
  });

  String formatDate(String rawDate) {
    final parsedDate = DateTime.tryParse(rawDate);
    if (parsedDate == null) return rawDate;

    return DateFormat('dd MMM yyyy').format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    final String type = announcement.type.toLowerCase();
    Color badgeBgColor;
    Color badgeTextColor;

    if (type == 'urgent') {
      badgeBgColor = const Color(0xFFFFF0E5);
      badgeTextColor = const Color(0xFFFF8A00);
    } else if (type == 'update') {
      badgeBgColor = const Color(0xFFE5F7ED);
      badgeTextColor = const Color(0xFF00C853);
    } else {
      badgeBgColor = const Color(0xFFE5EDFF);
      badgeTextColor = const Color(0xFF6B8AFF);
    }

    Widget? buildImageWidget() {
      final imgData = announcement.imageBase64;
      if (imgData == null || imgData.isEmpty) return null;

      if (imgData.startsWith('http://') || imgData.startsWith('https://')) {
        return Image.network(
          imgData,
          height: 150,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
        );
      }

      try {
        return Image.memory(
          base64Decode(imgData),
          height: 150,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
        );
      } catch (_) {
        return null;
      }
    }

    final imageWidget = buildImageWidget();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ?imageWidget,

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        announcement.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: badgeBgColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        announcement.type,
                        style: TextStyle(
                          color: badgeTextColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  announcement.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueGrey.shade700,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  formatDate(announcement.date),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
