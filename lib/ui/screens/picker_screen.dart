// ignore_for_file: unused_field, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media/models/media.dart';
import 'package:media/services/fetch_albums.dart';
import 'package:media/services/fetch_medias.dart';
import 'package:media/ui/components/media_grid_view.dart';
import 'package:photo_manager/photo_manager.dart';

class PickerScreen extends StatefulWidget {
  const PickerScreen({super.key});

  @override
  State<PickerScreen> createState() => _PickerScreenState();
}

class _PickerScreenState extends State<PickerScreen> {
  //?

  late final List<Media> _selectedMedias = [];
  AssetPathEntity? _currentAlbum;
  List<AssetPathEntity> _albums = [];

  void _loadAlbums() async {
    //?
    List<AssetPathEntity> tmpAlbums = await fetchAlbums();
    if (tmpAlbums.isNotEmpty) {
      setState(() {
        _currentAlbum = tmpAlbums.first;
        print("_currentAlbum : $_currentAlbum.toString()");
        _albums = tmpAlbums;
        print("_albums : $_albums.toString()");
      });
      _loadMedias();
    }
  }

  final List<Media> _medias = [];
  int _lastPage = 0;
  int _currentPage = 0;

  void _loadMedias() async {
    //?
    _lastPage = _currentPage;

    if (_currentAlbum != null) {
      List<Media> tmpMedias =
          await fetchMedias(album: _currentAlbum!, page: _currentPage);
      setState(() {
        _medias.addAll(tmpMedias);
      });
    }
  }

  @override
  void initState() {
    _selectedMedias.addAll(Get.arguments);
    print("101_selectedMedias : $_selectedMedias.toString()");
    _loadAlbums();
    super.initState();
    _scrollController.addListener(_loadMoreMedias);
  }

  final ScrollController _scrollController = ScrollController();

  void _loadMoreMedias() {
    if (_scrollController.position.pixels /
            _scrollController.position.maxScrollExtent >
        0.33) {
      if (_currentPage != _lastPage) {
        _loadMedias();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMoreMedias);
    _scrollController.dispose();
    super.dispose();
  }

  void _selectMedia(Media media) {
    //?
    bool isSelected = _selectedMedias
        .any((element) => element.assetEntity.id == media.assetEntity.id);
    setState(() {
      if (isSelected) {
        _selectedMedias.removeWhere(
            (element) => element.assetEntity.id == media.assetEntity.id);
      } else {
        _selectedMedias.add(media);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropdownButton<AssetPathEntity>(
          borderRadius: BorderRadius.circular(16.0),
          value: _currentAlbum,
          items: _albums
              .map(
                (e) => DropdownMenuItem<AssetPathEntity>(
                  value: e,
                  child: Text(e.name.isEmpty ? "0" : e.name),
                ),
              )
              .toList(),
          onChanged: (AssetPathEntity? value) {
            setState(() {
              _currentAlbum = value;
              _currentPage = 0;
              _lastPage = 0;
              _medias.clear();
              _loadMedias();
              _scrollController.jumpTo(0.0);
            });
          },
        ),
      ),
      body: MediaGridView(
        medias: _medias,
        selectedMedias: _selectedMedias,
        selectMedia: _selectMedia,
        scrollController: _scrollController,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.back(result: _selectedMedias);
        },
        child: const Icon(Icons.check_rounded),
      ),
    );
  }
}
