// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> grantPermissions() async {
  try {
    final bool videoGranted = await Permission.videos.isGranted;
    final bool photoGranted = await Permission.photos.isGranted;

    if (!photoGranted || !videoGranted) {
      final Map<Permission, PermissionStatus> statuses = await [
        Permission.videos,
        Permission.photos,
      ].request();
      if (statuses[Permission.videos] == PermissionStatus.permanentlyDenied ||
          statuses[Permission.photos] == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      }
    }
  } catch (e) {
    debugPrint("Grant Permission : $e");
  }
}
