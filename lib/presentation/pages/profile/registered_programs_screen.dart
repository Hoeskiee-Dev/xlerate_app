import 'package:flutter/material.dart';
import 'package:xlerate/domain/entities/joined_program.dart';

class RegisteredProgramsScreen extends StatelessWidget {
  final List<JoinedProgram> joinedPrograms;

  const RegisteredProgramsScreen({
    super.key,
    required this.joinedPrograms,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events Registered"),
        centerTitle: true,
      ),
      body: joinedPrograms.isEmpty
          ? const Center(
              child: Text("You haven't registered for any events yet."),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: joinedPrograms.length,
              itemBuilder: (context, index) {
                final program = joinedPrograms[index];

                final isAttended = program.status == 'Attended';

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  elevation: 0,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    title: Text(
                      program.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            size: 14,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            program.date,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isAttended
                            ? Colors.green.withOpacity(0.1)
                            : const Color(0xFFFF6B00).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        program.status,
                        style: TextStyle(
                          color: isAttended
                              ? Colors.green
                              : const Color(0xFFFF6B00),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
