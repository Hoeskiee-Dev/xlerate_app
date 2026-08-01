import 'dart:convert'; // Required for base64Decode
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xlerate/presentation/providers/user_provider.dart';

/// Screen allowing users to update their profile details (Name, Email, and Avatar)
/// with real-time cloud synchronization via Riverpod and MockAPI.
class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  // Input controllers for profile text fields
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  // Stores the newly selected image converted to a Base64 string
  String? _base64Image;

  // Loading state tracker to prevent interrupted asynchronous cloud saves
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill text controllers with current user data from Riverpod state
    final currentUser = ref.read(userProvider);
    _nameController = TextEditingController(text: currentUser?.name ?? '');
    _emailController = TextEditingController(text: currentUser?.email ?? '');
  }

  @override
  void dispose() {
    // Clean up text controllers to prevent memory leaks
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  /// Opens gallery image picker, compresses dimensions to fit MockAPI character limits,
  /// and converts the image bytes into a Base64 text string.
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    // Shrink dimensions down to a tiny icon size so MockAPI accepts the text string
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 80,
      maxHeight: 80,
      imageQuality: 50,
    );

    if (image != null) {
      final bytes = await image.readAsBytes();
      final base64String = base64Encode(bytes);

      setState(() {
        _base64Image = base64String;
      });
    }
  }

  /// Helper to decode Base64 image strings or fallback to remote URLs / default avatars.
  ImageProvider _getAvatarImage(String? avatarData) {
    if (avatarData != null && avatarData.length > 500) {
      return MemoryImage(base64Decode(avatarData));
    } else if (avatarData != null && avatarData.isNotEmpty) {
      return NetworkImage(avatarData);
    }
    return const NetworkImage("https://ui-avatars.com/api/?name=User");
  }

  @override
  Widget build(BuildContext context) {
    // Watch live user state
    final currentUser = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- INTERACTIVE AVATAR PICKER ---
            Center(
              child: GestureDetector(
                onTap: _isLoading
                    ? null
                    : _pickImage, // Disable picking while saving
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue.shade50,
                      backgroundImage: _getAvatarImage(
                        _base64Image ?? currentUser?.avatar,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Color(0xFF6F63F6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // --- FULL NAME INPUT FIELD ---
            TextField(
              controller: _nameController,
              enabled:
                  !_isLoading, // Disable editing while cloud update is running
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // --- EMAIL ADDRESS INPUT FIELD ---
            TextField(
              controller: _emailController,
              enabled:
                  !_isLoading, // Disable editing while cloud update is running
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),

            // --- SAVE CHANGES BUTTON ---
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6F63F6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              // Disable button if already processing network request
              onPressed: _isLoading
                  ? null
                  : () async {
                      // 1. Activate loading spinner and lock UI inputs
                      setState(() {
                        _isLoading = true;
                      });

                      // 2. AWAIT the cloud update to guarantee successful sync with MockAPI
                      await ref
                          .read(userProvider.notifier)
                          .updateProfile(
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            avatar: _base64Image ?? currentUser?.avatar,
                          );

                      // 3. Safety check to ensure widget is still active after async gap
                      if (!mounted) return;

                      // 4. Deactivate loading state
                      setState(() {
                        _isLoading = false;
                      });

                      // 5. Display success feedback notification
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Profile updated successfully! ✨',
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );

                      // 6. Return back to profile screen
                      Navigator.pop(context);
                    },
              child: _isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                  : const Text(
                      "Save Changes",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
