import 'package:flutter/material.dart';

IconData getLocationIcon(String type) {
  if (type == 'Virtual') return Icons.videocam_outlined;
  if (type == 'Hybrid') return Icons.devices_outlined;
  return Icons.location_on_outlined;
}
