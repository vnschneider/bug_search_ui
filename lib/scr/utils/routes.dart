import 'package:bug_search/scr/screens/forDeveloperPages/aboutProjectPage.dart';
import 'package:bug_search/scr/screens/forDeveloperPages/dataBasePage.dart';
import 'package:bug_search/scr/screens/forDeveloperPages/documentationPage.dart';
import 'package:bug_search/scr/screens/forDeveloperPages/overViewPage.dart';
import 'package:bug_search/scr/screens/searchPages/searchPage.dart';
import 'package:flutter/material.dart';

import '../screens/searchPages/homePage.dart';

Map<String, Widget Function(BuildContext)> routes = {
  'homePage': (context) => const HomePage(),
  'search': (context) => const SearchPage(),
  'forDev/overView': (context) => const OverViewPage(),
  'forDev/documentation': (context) => const DocumentationPage(),
  'forDev/dataBase': (context) => const DataBasePage(),
  'forDev/aboutProject': (context) => const AboutProjectPage(),
};
