import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'mobileLayout/home_page_mobile.dart';
import 'tabletLayout/home_page_tablet.dart';
import 'webLayout/home_page_web.dart';


class BugSearchUI extends StatelessWidget {
  const BugSearchUI({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ScreenTypeLayout.builder(
        mobile: (p0) => const BugSearchUIMobile(),
        tablet: (p0) => const BugSearchUITablet(),
        desktop: (p0) => const BugSearchUIWeb(),
      ),
    );
  }
}
