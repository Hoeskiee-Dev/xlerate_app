import 'package:flutter/material.dart';
import 'package:xlerate/domain/entities/program.dart'; // Adjust path if needed

/// Screen displayed after a user successfully registers for a program or event.
class ConfirmationScreen extends StatelessWidget {
  // The registered program entity containing name, schedule, and location info
  final Program program;

  const ConfirmationScreen({
    super.key,
    required this.program,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // --- 1. HUGE GREEN TICK WITH CIRCULAR BOX ---
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: const Color(0xFF15B79E), // Vibrant success green theme
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(
                        0xFF15B79E,
                      ).withOpacity(0.3), // Soft glowing drop shadow
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check_rounded, // Clean, rounded confirmation checkmark
                  size: 90,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),

              // --- 2. SUCCESS HEADINGS & DESCRIPTIONS ---
              const Text(
                "You are registered!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D2939),
                ),
              ),
              const SizedBox(height: 12),

              Text(
                "You've successfully joined\n${program.title}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF344054),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "It has been added to your calendar.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF667085),
                ),
              ),

              const SizedBox(height: 32),

              // --- 3. EVENT DETAILS SUMMARY CARD ---
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    _buildDetailRow(
                      Icons.calendar_today_outlined,
                      program.startDate,
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(Icons.access_time_outlined, program.time),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      Icons.location_on_outlined,
                      program.location,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // --- 4. REMINDER ACTION BUTTON ---
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xFFFF6A3D),
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // TODO: Implement native calendar reminder integration
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Reminder feature coming soon!"),
                      ),
                    );
                  },
                  child: const Text(
                    "Add task to reminder",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF6A3D),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // --- 5. NAVIGATION HOME BUTTON ---
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6A3D),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // Clears navigation stack and returns to the root dashboard
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text(
                    "Back to Home",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable helper widget to build clean, uniform key-value icon rows for event metadata.
  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey.shade600, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
