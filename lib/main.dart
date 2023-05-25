import 'package:flutter/material.dart';

import '../utils/routes.dart';
import '../utils/themeData.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowMaterialGrid: true,
      theme: themeData,
      routes: routes,
      initialRoute: 'homepage',
      debugShowCheckedModeBanner: false,
    );
  }
}
