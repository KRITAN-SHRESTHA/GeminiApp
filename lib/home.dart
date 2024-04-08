import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geminiapp/text_only_input.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    const String apiKey = String.fromEnvironment('API_KEY', defaultValue: '');

    @override
    void initState() {
      super.initState();
      if (apiKey.isEmpty) {
        exit(1);
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TextOnlyInput()));
              },
              child: const Text('Genereate Text from text-only input'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TextOnlyInput()));
              },
              child: const Text(
                  'Generate text from text-and-image input (multimodal)'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TextOnlyInput()));
              },
              child: const Text('Build multi-turn conversations (chat)'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TextOnlyInput()));
              },
              child: const Text('Use streaming for faster interactions'),
            ),
          ],
        ),
      ),
    );
  }
}
