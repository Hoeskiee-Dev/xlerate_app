import 'package:flutter/material.dart';

class ParticipantCard extends StatelessWidget {
  final Map<String, dynamic> participant;
  final Color brandOrange;

  const ParticipantCard({
    super.key,
    required this.participant,
    required this.brandOrange,
  });

  @override
  Widget build(BuildContext context) {
    final isAttended = participant['status'] == 'Attended';

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
            backgroundImage: NetworkImage(participant['image']),
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
