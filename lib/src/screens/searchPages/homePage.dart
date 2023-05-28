// ignore_for_file: file_names
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:bug_search/src/models/bsLogo.dart';
import 'package:bug_search/src/models/customButton.dart';
import 'package:bug_search/src/models/searchBar.dart';
import 'package:bug_search/src/models/switch_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSwitched = false;
  bool buttonHover = false;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 40, left: 62, right: 62),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton(
                text: 'For developers',
                isIconButton: true,
                icon: BootstrapIcons.gear,
                iconHover: BootstrapIcons.gear_fill,
                function: () => Navigator.pushNamed(context, 'fordev/overview'),
              ),
              const SizedBox(width: 40),
              customSwitchButton(
                  (p0) => {
                        setState(() {
                          isSwitched = p0;
                        })
                      },
                  isSwitched,
                  48,
                  88),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.25),
          //BODY//
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              //BRANDING//
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const BSLogo(),
                  Text(
                    ' | Bug Search',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ],
              ),

              CustomSearchBar(
                  searchController: _searchController,
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      Navigator.pushNamed(context, '/search', arguments: value);
                      _searchController.clear;
                    } else {
                      return;
                    }
                  },
                  onPress: () {
                    if (_searchController.text.isNotEmpty) {
                      Navigator.pushNamed(context, '/search',
                          arguments: _searchController.text);
                      _searchController.clear;
                    } else {
                      return;
                    }
                  },
                  height: 52,
                  width: 660),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Mais de ',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                      children: [
                        TextSpan(
                          text: 'XXX ',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                        TextSpan(
                          text: 'sites indexados, e mais de ',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        TextSpan(
                          text: 'XXX ',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                        TextSpan(
                          text: 'termos no dicionário.',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          /*  Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                //height: MediaQuery.of(context).size.height * 0.42,
                width: MediaQuery.of(context).size.width <= 1200
                    ? MediaQuery.of(context).size.width * 0.4
                    : MediaQuery.of(context).size.width * 0.18,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  color: Theme.of(context).colorScheme.primary,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                tooltip: 'Sobre',
                                iconSize: 26,
                                hoverColor: const Color(0xff657AFF),
                                highlightColor: const Color(0xff848FFF),
                                onPressed: () {},
                                icon: const Icon(
                                  Iconsax.information,
                                  color: Color(0xffFAFAFB),
                                ),
                              ),
                              const SizedBox(width: 2),
                              const Text(
                                'Sobre o projeto',
                                style: TextStyle(
                                  color: Color(0xffFAFAFB),
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w400,
                                  //fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 25,
                            style: TextStyle(
                              color: ThemeData.from(
                                      colorScheme: const ColorScheme.light())
                                  .colorScheme
                                  .onPrimary,

                              // overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.normal,
                              //fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),*/
        ],
      ),
    ));
  }
}
