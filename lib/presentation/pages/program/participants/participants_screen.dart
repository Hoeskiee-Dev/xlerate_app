import 'package:flutter/material.dart';
import 'package:xlerate/domain/entities/program.dart';
import 'widgets/premium_stat_box.dart';
import 'widgets/premium_action_square.dart';
import 'widgets/participant_card.dart';

class ParticipantsScreen extends StatefulWidget {
  final Program program;

  const ParticipantsScreen({
    super.key,
    required this.program,
  });

  @override
  State<ParticipantsScreen> createState() => _ParticipantsScreenState();
}

class _ParticipantsScreenState extends State<ParticipantsScreen> {
  final Color _brandOrange = const Color(0xFFFF6B00);

  // Mock data
  final List<Map<String, dynamic>> participants = [
    {
      "name": "Ferry Gunawan",
      "email": "ferry@gmail.com",
      "image": "https://i.pravatar.cc/150?img=11",
      "status": "Attended",
    },
    {
      "name": "Bishvajit Kumar",
      "email": "biscuit@gmail.com",
      "image": "https://i.pravatar.cc/150?img=12",
      "status": "Registered",
    },
    {
      "name": "Ferry Gunawan",
      "email": "ferry@gmail.com",
      "image": "https://i.pravatar.cc/150?img=11",
      "status": "Attended",
    },
    {
      "name": "Bishvajit Kumar",
      "email": "biscuit@gmail.com",
      "image": "https://i.pravatar.cc/150?img=12",
      "status": "Registered",
    },
    {
      "name": "Ferry Gunawan",
      "email": "ferry@gmail.com",
      "image": "https://i.pravatar.cc/150?img=11",
      "status": "Attended",
    },
    {
      "name": "Bishvajit Kumar",
      "email": "biscuit@gmail.com",
      "image": "https://i.pravatar.cc/150?img=12",
      "status": "Registered",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final int attendedCount = participants
        .where((p) => p['status'] == 'Attended')
        .length;
    final int registeredCount = widget.program.joinedCount;

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
      body: Column(
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
                  gradientColors: [Colors.blue.shade400, Colors.blue.shade700],
                ),
                const SizedBox(width: 16),
                PremiumStatBox(
                  label: 'Attended',
                  count: attendedCount.toString(),
                  gradientColors: [Colors.teal.shade400, Colors.green.shade600],
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

          // 4. Clean List View!
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 32,
                left: 20,
                right: 20,
              ),
              itemCount: participants.length,
              itemBuilder: (context, index) {
                return ParticipantCard(
                  participant: participants[index],
                  brandOrange: _brandOrange,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
