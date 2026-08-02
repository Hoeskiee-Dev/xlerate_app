import 'package:flutter/material.dart';
import 'package:xlerate/domain/entities/program.dart';
import 'package:xlerate/presentation/pages/program/participants/participants_screen.dart';

Widget attendies(BuildContext context, Program program) {
  final bool isUnlimited = program.totalSeats == null;
  final int seatsLeft = isUnlimited
      ? 0
      : program.totalSeats! - program.joinedCount;

  return Padding(
    padding: const EdgeInsets.all(16),
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
          child: Row(
            children: [
              SizedBox(
                width: 150,
                height: 44,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    const CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.amber,
                      child: Text("S"),
                    ),
                    const Positioned(
                      left: 30,
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.red,
                        child: Text("F"),
                      ),
                    ),
                    const Positioned(
                      left: 60,
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.green,
                        child: Text("G"),
                      ),
                    ),
                    const Positioned(
                      left: 90,
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.grey,
                        child: Text("+"),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${program.joinedCount} joined",
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),

        const Spacer(),

        // * Seats number
        Column(
          children: [
            const Text("No. of seats left"),
            Text(
              isUnlimited ? "Unlimited" : "$seatsLeft Seat(s)",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
