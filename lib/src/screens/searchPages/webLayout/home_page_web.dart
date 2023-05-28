import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:bug_search/src/models/bsLogo.dart';
import 'package:bug_search/src/models/customButton.dart';
import 'package:bug_search/src/models/searchBar.dart';
import 'package:bug_search/src/models/switch_button.dart';
import 'package:flutter/material.dart';

class BugSearchUIWeb extends StatefulWidget {
  const BugSearchUIWeb({super.key});

  @override
  State<BugSearchUIWeb> createState() => _BugSearchUIWebState();
}

class _BugSearchUIWebState extends State<BugSearchUIWeb> {
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
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1,
          vertical: MediaQuery.of(context).size.height * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: 'button',
                child: CustomButton(
                  text: 'For developers',
                  isIconButton: true,
                  icon: BootstrapIcons.gear,
                  iconHover: BootstrapIcons.gear_fill,
                  function: () =>
                      Navigator.pushNamed(context, 'fordev/overview'),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.03),
              Hero(
                tag: 'switch',
                child: customSwitchButton(
                    (p0) => {
                          if (mounted)
                            {
                              setState(() {
                                isSwitched = p0;
                              })
                            }
                        },
                    isSwitched,
                    MediaQuery.of(context).size.height * 0.06,
                    MediaQuery.of(context).size.width * 0.06),
              ),
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
                  const Hero(tag: 'logo', child: BSLogo()),
                  Text(
                    '/ Bug Search',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ],
              ),

              Hero(
                tag: 'searchBar',
                child: CustomSearchBar(
                    searchController: _searchController,
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        Navigator.pushNamed(context, '/search',
                            arguments: value);
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
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.4),
              ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
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
        ],
      ),
    ));
  }
}
