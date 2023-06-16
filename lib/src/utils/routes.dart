import 'package:bug_search/src/screens/forDeveloperPages/aboutProjectPage.dart';
import 'package:bug_search/src/screens/forDeveloperPages/dataBasePage.dart';
import 'package:bug_search/src/screens/forDeveloperPages/documentationPage.dart';
import 'package:bug_search/src/screens/forDeveloperPages/overViewPage.dart';
//import 'package:bug_search/src/screens/searchPages/searchPage.dart';
import 'package:flutter/material.dart';
import '../screens/searchPages/bug_search_ui.dart';
import '../screens/searchPages/webLayout/home_page_web.dart';
//import '../screens/searchPages/homePage.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const HomePageUI(),
  '/homepageweb': (context) => const BugSearchUIWeb(),
  '/search': (context) => const SearchPageUI(),
  '/fordev/overview': (context) => const OverViewPage(),
  '/fordev/documentation': (context) => const DocumentationPage(),
  '/fordev/database': (context) => const DataBasePage(),
  '/fordev/aboutproject': (context) => const AboutProjectPage(),
};
