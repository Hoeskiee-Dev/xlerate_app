import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/core/error_helper.dart';
import 'package:xlerate/domain/entities/program.dart';
import 'package:xlerate/presentation/misc/methods.dart';
import 'package:xlerate/presentation/pages/program/program_detail/program_detail_page.dart';

Widget programList(
  BuildContext context,
  AsyncValue<List<Program>> programListData,
) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Best Program for You",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      verticalSpaces(8),

      // * Handle AsyncValue State (Data, Loading, Error)
      programListData.when(
        data: (programs) {
          if (programs.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(child: Text("No programs available")),
            );
          }

          return ListView.separated(
            itemCount: programs.length > 6 ? 6 : programs.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) =>
                programCard(context, programs[index]),
            separatorBuilder: (context, index) => verticalSpaces(12),
          );
        },
        loading: () => const Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: CircularProgressIndicator(
              color: Colors.deepOrangeAccent,
            ),
          ),
        ),
        error: (error, stack) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.wifi_off_rounded,
                  color: Colors.grey,
                  size: 40,
                ),
                const SizedBox(height: 8),
                Text(
                  getReadableErrorMessage(error),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  ),
);

Widget programCard(BuildContext context, Program program) => GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProgramDetailPage(programId: program.id!),
      ),
    );
  },
  child: Container(
    padding: const EdgeInsets.all(12),
    height: 125,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 5,
          offset: const Offset(4, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            program.imageUrl,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 100,
              width: 100,
              color: Colors.grey.shade200,
              child: const Icon(Icons.image_not_supported, color: Colors.grey),
            ),
          ),
        ),

        horizontalSpaces(12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                program.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                program.speaker ?? program.host,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    program.startDate,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    program.host,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
