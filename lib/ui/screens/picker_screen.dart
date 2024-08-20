// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media/models/media.dart';
import 'package:media/services/fetch_albums.dart';
import 'package:photo_manager/photo_manager.dart';

class PickerScreen extends StatefulWidget {
  const PickerScreen({super.key});

  @override
  State<PickerScreen> createState() => _PickerScreenState();
}

class _PickerScreenState extends State<PickerScreen> {
  //?

  late List<Media> selectedMedias = [];
  AssetPathEntity? currentAlbum;
  List<AssetPathEntity> _albums = [];

  void _loadAlbums() async {
    List<AssetPathEntity> tmpAlbums = await fetchAlbums();
    if (tmpAlbums.isNotEmpty) {
      setState(() {
        currentAlbum = tmpAlbums.first;
        _albums = tmpAlbums;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    selectedMedias.addAll(Get.arguments);
    _loadAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
