import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media/models/media.dart';
import 'package:media/ui/screens/picker_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Media> selectedMedias = [];

  Future<void> _handleButton() async {
    List<Media>? result =
        await Get.to(() => const PickerScreen(), arguments: selectedMedias);

    if (result != null) {
      _updateSelectedMedias(result);
    }
  }

  void _updateSelectedMedias(List<Media> result) {
    setState(() {
      selectedMedias.clear();
      selectedMedias.addAll(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Media Picker",
        ),
      ),
      body: ListView.builder(
        itemCount: selectedMedias.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: selectedMedias[index].widget,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleButton,
        child: const Icon(Icons.image_outlined),
      ),
    );
  }
}
