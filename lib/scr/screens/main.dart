import 'package:flutter/material.dart';

import '../utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowMaterialGrid: true,
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: routes,
      initialRoute: 'homepage',
      debugShowCheckedModeBanner: false,
    );
  }
}
