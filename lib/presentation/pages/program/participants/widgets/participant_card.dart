import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ParticipantCard extends StatelessWidget {
  final Map<String, dynamic> participant;
  final Color brandOrange;

  const ParticipantCard({
    super.key,
    required this.participant,
    required this.brandOrange,
  });

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

  @override
  Widget build(BuildContext context) {
    final isAttended = participant['status'] == 'Attended';
    final name = participant['name'] ?? 'Unknown';
    final email = participant['email'] ?? '';
    final avatarImage = _getAvatarImage(participant['image']);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade200, width: 2),
          ),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: brandOrange.withOpacity(0.1),
            backgroundImage: avatarImage,
            child: avatarImage == null
                ? Text(
                    name.isNotEmpty ? name[0].toUpperCase() : '?',
                    style: TextStyle(
                      color: brandOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )
                : null,
          ),
        ),
        title: Text(
          participant['name'],
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        subtitle: Text(
          participant['email'],
          style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isAttended
                ? Colors.green.shade50
                : brandOrange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            participant['status'],
            style: TextStyle(
              color: isAttended ? Colors.green.shade700 : brandOrange,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
