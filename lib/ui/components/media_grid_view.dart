import 'package:flutter/material.dart';
import 'package:media/models/media.dart';

class MediaGridView extends StatelessWidget {
  final List<Media> medias;
  final List<Media> selectedMedia;
  final Function(Media) selectMedia;
  final ScrollController scrollController;
  const MediaGridView({
    super.key,
    required this.medias,
    required this.selectedMedia,
    required this.selectMedia,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      itemCount: medias.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 3,
        crossAxisSpacing: 3,
      ),
      itemBuilder: (context, index) {
        return null;
      },
    );
  }
}
