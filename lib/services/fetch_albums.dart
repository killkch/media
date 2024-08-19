import 'package:flutter/material.dart';
import 'package:media/services/grant_permission.dart';
import 'package:photo_manager/photo_manager.dart';

Future<List<AssetPathEntity>> fetchAlbums() async {
  try {
    /**
     * fetch 하기전에 permission 확인한다. 
     */
    await grantPermissions();

    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList();

    return albums;
  } catch (e) {
    debugPrint("FetchAlbums Error : $e");
    return [];
  }
}
