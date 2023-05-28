// ignore_for_file: file_names

import 'package:flutter/material.dart';

class DataBasePage extends StatefulWidget {
  const DataBasePage({super.key});

  @override
  State<DataBasePage> createState() => _DataBasePageState();
}

class _DataBasePageState extends State<DataBasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {},
          child: const Text("Data Base"),
        ),
      ),
    );
  }
}
