import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  Future<void> _handleButton() async {

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Media Picker",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleButton,
        child: const Icon(Icons.image_outlined),
      ),
    );
  }
}
