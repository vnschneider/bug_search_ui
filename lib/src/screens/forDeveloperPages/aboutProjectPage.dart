// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AboutProjectPage extends StatefulWidget {
  const AboutProjectPage({super.key});

  @override
  State<AboutProjectPage> createState() => _AboutProjectPageState();
}

class _AboutProjectPageState extends State<AboutProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {},
          child: const Text("About Project"),
        ),
      ),
    );
  }
}
