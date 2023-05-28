// ignore_for_file: file_names
import 'package:flutter/material.dart';

class BSLogoMobile extends StatelessWidget {
  final double fontsize;
  const BSLogoMobile({super.key, required this.fontsize});

  @override
  Widget build(BuildContext context) {
    return Text('BS',
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: fontsize,
              color: Theme.of(context).colorScheme.primary,
            ));
  }
}
