import 'dart:convert'; // REQUIRED to decode the Base64 text back into an image
import 'package:flutter/material.dart';
import '../../../../domain/entities/user_model.dart';

/// A stateless widget that renders the top profile summary section,
/// displaying the user avatar (with support for Base64 blobs and network URLs),
/// their role badge, name, email, and a bottom divider.
class ProfileHeader extends StatelessWidget {
  // The user entity containing profile details
  final UserModel user;

  const ProfileHeader({
    super.key,
    required this.user,
  });

  /// returning the appropriate ImageProvider for the avatar.
  ImageProvider? _getAvatarImage(String? avatarData) {
    if (avatarData == null || avatarData.isEmpty) {
      return null; // Return null so CircleAvatar renders the child icon fallback
    }

    if (avatarData.length > 500) {
      // Decode massive Base64 text string back into raw memory image bytes
      return MemoryImage(base64Decode(avatarData));
    }
    return NetworkImage(avatarData);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --- USER AVATAR THUMBNAIL ---
        CircleAvatar(
          radius: 45,
          backgroundColor: const Color(0xFFE8F0FE),
          backgroundImage: _getAvatarImage(user.avatar),
          child: user.avatar == null || user.avatar!.isEmpty
              ? const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.blue,
                )
              : null,
        ),

        const SizedBox(height: 12),

        // --- USER ROLE BADGE ---
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            user.role,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: 15),

        // --- USER FULL NAME ---
        Text(
          user.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        // --- USER EMAIL ADDRESS ---
        Text(
          user.email,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),

        const SizedBox(height: 20),

        // --- SECTION SEPARATOR DIVIDER ---
        Divider(
          color: Colors.grey.shade300,
        ),
      ],
    );
  }
}
