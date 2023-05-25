// ignore_for_file: file_names
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:bug_search/scr/models/bsLogo.dart';
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

  void _toggleTap() {
    setState(() {
      _isTapped = !_isTapped;
      if (_isTapped) {
        _isTapped1 = false;
        _isTapped2 = false;
        _isTapped3 = false;
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 60, right: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'homepage');
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
                    const CustomSearchBar(height: 48, width: 560),
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
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 110),
                GestureDetector(
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
            Divider(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              thickness: 1,
            ),
            Row(
              children: [
                const SizedBox(width: 110),
                Text('Aproximadamente XXX resultados encontrados',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        )),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 110),
                Text(
                  'Resultados da Web',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
