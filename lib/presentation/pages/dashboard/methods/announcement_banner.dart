import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/domain/entities/announcement.dart';
import 'package:xlerate/presentation/misc/methods.dart';
import 'package:xlerate/presentation/pages/announcement/announcement_screen.dart';
import 'package:xlerate/presentation/providers/announcement_provider.dart';

Widget announcementBanner(
  BuildContext context,
  WidgetRef ref, {
  required int currentIndex,
  required Function(int) onPageChanged,
}) {
  final announcementsAsyncValue = ref.watch(announcementListProvider);

  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
    child: announcementsAsyncValue.when(
      data: (announcements) {
        if (announcements.isEmpty) {
          return const SizedBox.shrink();
        }

        final displayList = announcements.reversed.take(5).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              children: [
                CarouselSlider(
                  items: displayList.map((item) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.blueGrey.shade800,
                        image: _getDecorationImage(item.imageBase64),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.8),
                              Colors.black.withOpacity(0.2),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              item.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            verticalSpaces(4),
                            Text(
                              item.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 175,
                    autoPlay: true,
                    viewportFraction: 0.9,
                    disableCenter: true,
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) {
                      onPageChanged(index);
                    },
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: displayList.asMap().entries.map((entry) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(
                            currentIndex == entry.key ? 0.9 : 0.4,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),

            verticalSpaces(8),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AnnouncementScreen(),
                  ),
                );
              },
              child: const Text(
                "See Announcements ->",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
      loading: () => Container(
        height: 175,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, _) => const SizedBox.shrink(),
    ),
  );
}

DecorationImage? _getDecorationImage(String? imageStr) {
  if (imageStr == null || imageStr.isEmpty) {
    return const DecorationImage(
      image: NetworkImage('https://picsum.photos/400/200'),
      fit: BoxFit.cover,
    );
  }

  if (imageStr.startsWith('http://') || imageStr.startsWith('https://')) {
    return DecorationImage(
      image: NetworkImage(imageStr),
      fit: BoxFit.cover,
    );
  }

  try {
    return DecorationImage(
      image: MemoryImage(base64Decode(imageStr)),
      fit: BoxFit.cover,
    );
  } catch (_) {
    return const DecorationImage(
      image: NetworkImage('https://picsum.photos/400/200'),
      fit: BoxFit.cover,
    );
  }
}
