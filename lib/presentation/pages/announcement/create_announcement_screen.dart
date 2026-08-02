import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xlerate/domain/entities/announcement.dart';
import 'package:xlerate/presentation/providers/announcement_provider.dart';

class CreateAnnouncementScreen extends ConsumerStatefulWidget {
  const CreateAnnouncementScreen({super.key});

  @override
  ConsumerState<CreateAnnouncementScreen> createState() =>
      _CreateAnnouncementScreenState();
}

class _CreateAnnouncementScreenState
    extends ConsumerState<CreateAnnouncementScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  String priority = "Urgent";
  bool sendNotification = true;
  bool isLoading = false;

  File? _selectedImage;
  String? _imageBase64;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );

    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _selectedImage = File(image.path);
        _imageBase64 = base64Encode(bytes);
      });
    }
  }

  Future<void> _createAnnouncement() async {
    if (titleController.text.trim().isEmpty ||
        messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final newAnnouncement = Announcement(
        title: titleController.text.trim(),
        description: messageController.text.trim(),
        date: "3 Aug 2026",
        type: priority,
        imageBase64: _imageBase64,
      );

      await ref
          .read(announcementActionProvider)
          .createAnnouncement(newAnnouncement);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Announcement Created Successfully!")),
      );
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("An error occurred: $e")));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: _circleButton(Icons.arrow_back_ios_new),
                  ),
                  const Text(
                    "New Announcement",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff364152),
                    ),
                  ),
                  const SizedBox(width: 42, height: 42),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          height: 170,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xffE8ECF3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: _selectedImage != null
                              ? Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                )
                              : const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_photo_alternate_outlined,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "Upload Image",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Announcement Title",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Message",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: messageController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Announcement Priority",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          ChoiceChip(
                            label: const Text("Urgent"),
                            selected: priority == "Urgent",
                            onSelected: (value) =>
                                setState(() => priority = "Urgent"),
                          ),
                          const SizedBox(width: 10),
                          ChoiceChip(
                            label: const Text("Normal"),
                            selected: priority == "Normal",
                            onSelected: (value) =>
                                setState(() => priority = "Normal"),
                          ),
                          const SizedBox(width: 10),
                          ChoiceChip(
                            label: const Text("Update"),
                            selected: priority == "Update",
                            onSelected: (value) =>
                                setState(() => priority = "Update"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Send Notification to learners?",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<bool>(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              title: const Text(
                                "Send notification",
                                style: TextStyle(fontSize: 13),
                              ),
                              value: true,
                              groupValue: sendNotification,
                              onChanged: (value) =>
                                  setState(() => sendNotification = value!),
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<bool>(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              title: const Text(
                                "Don't send",
                                style: TextStyle(fontSize: 13),
                              ),
                              value: false,
                              groupValue: sendNotification,
                              onChanged: (value) =>
                                  setState(() => sendNotification = value!),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff635BFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: isLoading ? null : _createAnnouncement,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Create Announcement",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleButton(IconData icon) {
    return Container(
      height: 42,
      width: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(icon, size: 18, color: Colors.grey),
    );
  }
}
