// ignore_for_file: file_names
import 'dart:convert';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:bug_search/scr/models/bsLogo.dart';
import 'package:bug_search/scr/models/results.dart';
import 'package:bug_search/scr/models/searchBar.dart';
import 'package:flutter/material.dart';

import '../../models/switch_button.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isSwitched = false;
  bool onClick = false;
  bool _isTapped = true;
  bool _isTapped1 = false;
  bool _isTapped2 = false;
  bool _isTapped3 = false;
  static final List<SearchResults> searchResults = [];
  static List<SearchResults> get _searchResults => searchResults;

  void getResults() {
    /* for (int index = _searchResults.length - 1; index >= 0; index--) {
      searchResults.add(SearchResults(
        title: _searchResults[index].title,
        description: _searchResults[index].description,
        url: _searchResults[index].url,
      ));
    }*/
  }

  @override
  void initState() {
    getResults();
    print('LIST ITEMS');
    print(searchResults);
    super.initState();
  }

  void _toggleTap() {
    setState(() {
      _isTapped = !_isTapped;
      if (_isTapped) {
        _isTapped1 = false;
        _isTapped2 = false;
        _isTapped3 = false;
      } else if (!_isTapped) {
        _isTapped = true;
      }
    });
  }

  void _toggleTap1() {
    setState(() {
      _isTapped1 = !_isTapped1;
      if (_isTapped1) {
        _isTapped = false;
        _isTapped2 = false;
        _isTapped3 = false;
      } else if (!_isTapped1) {
        _isTapped1 = true;
      }
    });
  }

  void _toggleTap2() {
    setState(() {
      _isTapped2 = !_isTapped2;
      if (_isTapped2) {
        _isTapped = false;
        _isTapped1 = false;
        _isTapped3 = false;
      } else if (!_isTapped2) {
        _isTapped2 = true;
      }
    });
  }

  void _toggleTap3() {
    setState(() {
      _isTapped3 = !_isTapped3;
      if (_isTapped3) {
        _isTapped = false;
        _isTapped1 = false;
        _isTapped2 = false;
      } else if (!_isTapped3) {
        _isTapped3 = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 62, right: 62),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                        style: Theme.of(context)
                            .textButtonTheme
                            .style
                            ?.copyWith(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                        child: const BSLogo()),
                    Text(
                      ' |',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    CustomSearchBar(
                        height: 48,
                        width: MediaQuery.of(context).size.width * 0.4),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      tooltip: 'Favoritos',
                      hoverColor: Theme.of(context).colorScheme.secondary,
                      highlightColor: Theme.of(context).colorScheme.tertiary,
                      isSelected: onClick,
                      selectedIcon: const Icon(BootstrapIcons.bookmark_fill),
                      onPressed: () {
                        setState(() {
                          onClick = !onClick;
                        });
                      },
                      icon: const Icon(BootstrapIcons.bookmark),
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
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 190),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: _toggleTap,
                  child: Text(
                    'Todos',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight:
                              _isTapped ? FontWeight.w600 : FontWeight.w400,
                          color: _isTapped
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: _toggleTap1,
                  child: Text(
                    'Imagens',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight:
                              _isTapped1 ? FontWeight.w600 : FontWeight.w400,
                          color: _isTapped1
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: _toggleTap2,
                  child: Text(
                    'Vídeos',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight:
                              _isTapped2 ? FontWeight.w600 : FontWeight.w400,
                          color: _isTapped2
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: _toggleTap3,
                  child: Text(
                    'Documentos',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight:
                              _isTapped3 ? FontWeight.w600 : FontWeight.w400,
                          color: _isTapped3
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 190),
            child: Row(
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Aproximadamente ',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    children: [
                      TextSpan(
                        text: 'XXX ',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w900,
                              // fontSize: 14,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                      TextSpan(
                        text: 'resultados encontrados ',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // RESULTADO DA PESQUISA //
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 190),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Resultados da Web',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
// ListView //

          Flexible(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (BuildContext context, int index) {
                final searchResults = _searchResults[index];
                return ListTile(
                  title: Text(
                    searchResults.title,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  subtitle: Text(
                    searchResults.description,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  trailing: Text(
                    searchResults.url,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
