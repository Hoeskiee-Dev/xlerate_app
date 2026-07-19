import 'dart:io';

class Program {
  final String title;
  final String description;
  final String host;
  final String? speaker; // New
  final String startDate; // Updated from 'date'
  final String? endDate; // New (for multi-day)
  final String time;
  final String locationType; // New (In-Person, Virtual, Hybrid)
  final String location;
  final String tag;
  final List<String> skills; // New
  final String eligibility; // New
  final bool isFree; // New
  final double fee; // New
  final bool offersCertificate; // New
  final bool offersBadge; // New
  final String imageUrl;
  final File? imageFile;

  Program({
    required this.title,
    required this.description,
    required this.host,
    this.speaker,
    required this.startDate,
    this.endDate,
    required this.time,
    required this.locationType,
    required this.location,
    required this.tag,
    required this.skills,
    required this.eligibility,
    required this.isFree,
    required this.fee,
    required this.offersCertificate,
    required this.offersBadge,
    required this.imageUrl,
    this.imageFile,
  });
}

// The Global List starts completely EMPTY
List<Program> globalPrograms = [];
