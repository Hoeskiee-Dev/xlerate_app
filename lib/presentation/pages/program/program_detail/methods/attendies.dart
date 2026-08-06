import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/domain/entities/program.dart';
import 'package:xlerate/presentation/pages/program/participants/participants_screen.dart';
import 'package:xlerate/presentation/providers/participants/participants_list_provider.dart';

Widget attendies(BuildContext context, Program program) {
  final bool isUnlimited = program.totalSeats == null;
  final int seatsLeft = isUnlimited
      ? 0
      : program.totalSeats! - program.joinedCount;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ParticipantsScreen(
                  program: program,
                ),
              ),
            );
          },
          child: Consumer(
            builder: (context, ref, child) {
              final participantsAsync = ref.watch(
                getParticipantsProvider(userIds: program.joinedUserIds),
              );

              return participantsAsync.when(
                data: (users) {
                  final displayUsers = users.take(3).toList();
                  final int displayCount = displayUsers.length;

                  final double stackWidth = displayCount == 0
                      ? 0
                      : 52.0 + ((displayCount - 1) * 24.0);

                  return Row(
                    children: [
                      if (displayCount > 0) ...[
                        SizedBox(
                          width: stackWidth,
                          height: 52,
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: List.generate(displayUsers.length, (
                              index,
                            ) {
                              final user = displayUsers[index];
                              return Positioned(
                                left: index * 24.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 24,
                                    backgroundColor: const Color(
                                      0xFFFF6B00,
                                    ).withOpacity(0.15),
                                    backgroundImage: _getAvatarImage(
                                      user.avatar,
                                    ),
                                    child: _getAvatarImage(user.avatar) == null
                                        ? Text(
                                            user.name.isNotEmpty
                                                ? user.name[0].toUpperCase()
                                                : '?',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFFF6B00),
                                            ),
                                          )
                                        : null,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        "${program.joinedCount} joined",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                },
                loading: () => SizedBox(
                  height: 52,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${program.joinedCount} joined",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                error: (_, _) => Text(
                  "${program.joinedCount} joined",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              );
            },
          ),
        ),

        const Spacer(),

        // * Seats number
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "No. of seats left",
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            Text(
              isUnlimited ? "Unlimited" : "$seatsLeft Seat(s)",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

ImageProvider? _getAvatarImage(String? imageSource) {
  if (imageSource == null || imageSource.trim().isEmpty) return null;

  final trimmed = imageSource.trim();

  if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
    return NetworkImage(trimmed);
  }

  try {
    String cleanBase64 = trimmed;
    if (trimmed.contains(',')) {
      cleanBase64 = trimmed.split(',').last;
    }
    final Uint8List bytes = base64Decode(cleanBase64);
    return MemoryImage(bytes);
  } catch (_) {
    return null;
  }
}
