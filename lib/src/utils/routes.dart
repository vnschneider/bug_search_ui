import 'package:bug_search/src/screens/forDeveloperPages/aboutProjectPage.dart';
import 'package:bug_search/src/screens/forDeveloperPages/dataBasePage.dart';
import 'package:bug_search/src/screens/forDeveloperPages/documentationPage.dart';
import 'package:bug_search/src/screens/forDeveloperPages/overViewPage.dart';
import 'package:bug_search/src/screens/searchPages/searchPage.dart';
import 'package:flutter/material.dart';

import '../screens/searchPages/homePage.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const HomePage(),
  '/search': (context) => const SearchPage(),
  'fordev/overview': (context) => const OverViewPage(),
  'fordev/documentation': (context) => const DocumentationPage(),
  'fordev/database': (context) => const DataBasePage(),
  'fordev/aboutproject': (context) => const AboutProjectPage(),
};
