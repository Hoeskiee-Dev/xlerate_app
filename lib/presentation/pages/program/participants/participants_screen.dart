import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/domain/entities/program.dart';
import 'package:xlerate/domain/entities/user_model.dart';
import 'package:xlerate/presentation/providers/participants/participants_list_provider.dart';
import 'widgets/premium_stat_box.dart';
import 'widgets/premium_action_square.dart';
import 'widgets/participant_card.dart';

class ParticipantsScreen extends ConsumerStatefulWidget {
  final Program program;

  const ParticipantsScreen({
    super.key,
    required this.program,
  });

  @override
  ConsumerState<ParticipantsScreen> createState() => _ParticipantsScreenState();
}

class _ParticipantsScreenState extends ConsumerState<ParticipantsScreen> {
  final Color _brandOrange = const Color(0xFFFF6B00);

  Map<String, dynamic> _mapUserToParticipantMap(UserModel user) {
    return {
      "name": user.name,
      "email": user.email,
      "image": user.avatar,
      "status": "Registered",
    };
  }

  @override
  Widget build(BuildContext context) {
    final participantsAsync = ref.watch(
      getParticipantsProvider(userIds: widget.program.joinedUserIds),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Participants',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: participantsAsync.when(
        data: (users) {
          final registeredCount = users.length;
          // Catatan: Jika ada logika/flag khusus di backend untuk 'Attended', sesuaikan filter berikut
          final attendedCount = 0;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Program Title
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 8.0,
                ),
                child: Text(
                  widget.program.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                    letterSpacing: -0.5,
                  ),
                ),
              ),

              // 2. Stats Boxes
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 16.0,
                ),
                child: Row(
                  children: [
                    PremiumStatBox(
                      label: 'Registered',
                      count: registeredCount.toString(),
                      gradientColors: [
                        Colors.blue.shade400,
                        Colors.blue.shade700,
                      ],
                    ),
                    const SizedBox(width: 16),
                    PremiumStatBox(
                      label: 'Attended',
                      count: attendedCount.toString(),
                      gradientColors: [
                        Colors.teal.shade400,
                        Colors.green.shade600,
                      ],
                    ),
                  ],
                ),
              ),

              // 3. Action Squares
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PremiumActionSquare(
                      icon: Icons.file_download_outlined,
                      label: 'Import\nCSV',
                      iconColor: Colors.purple,
                    ),
                    const PremiumActionSquare(
                      icon: Icons.copy_outlined,
                      label: 'Copy\nEmail',
                      iconColor: Colors.blue,
                    ),
                    PremiumActionSquare(
                      icon: Icons.notifications_outlined,
                      label: 'Send\nAlert',
                      iconColor: _brandOrange,
                    ),
                    PremiumActionSquare(
                      icon: Icons.workspace_premium_outlined,
                      label: 'Award\nCert',
                      iconColor: Colors.amber.shade600,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 8.0,
                ),
                child: Text(
                  'List of Participants',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade900,
                  ),
                ),
              ),

              // 4. Actual Data List View!
              Expanded(
                child: users.isEmpty
                    ? const Center(
                        child: Text(
                          "No participants joined yet.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 32,
                          left: 20,
                          right: 20,
                        ),
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final participantMap = _mapUserToParticipantMap(
                            users[index],
                          );
                          return ParticipantCard(
                            participant: participantMap,
                            brandOrange: _brandOrange,
                          );
                        },
                      ),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 40),
              const SizedBox(height: 8),
              Text(
                "Failed to load participants:\n$error",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
