// ignore_for_file: file_names
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:bug_search/scr/models/customButton.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButton(
          text: 'Search',
          isIconButton: true,
          icon: BootstrapIcons.search,
          iconHover: BootstrapIcons.safe2_fill,
          function: () {},
        ),
      ),
    );
  }
}
