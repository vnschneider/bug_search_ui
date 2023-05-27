// ignore_for_file: file_names, avoid_print

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:bug_search/src/functions/get_results.dart';
import 'package:bug_search/src/models/bsLogo.dart';
import 'package:bug_search/src/models/searchBar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/switch_button.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isSwitched = false;
  bool getResults = false;
  bool onClick = false;
  bool _isTapped = true;
  bool _isTapped1 = false;
  bool _isTapped2 = false;
  bool _isTapped3 = false;
  bool isHovered = false;
  List<dynamic> resultsFromJson = [];
  int resultsLength = 0;
  String searchKey = '';
  int searchDensity = 20;
  final _searchController = TextEditingController();

  @override
  void initState() {
    fetchDataFromAPI();

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void getSearchValue(value) {
    searchKey = value;
    if (getResults == false) {
      _searchController.text = value;
    }
  }

  Stream fetchDataFromAPI() async* {
    try {
      List data = await fetchData2(
          'http://40.76.148.166/search?q=$searchKey&l=${searchDensity.toString()}');

      setState(() {
        resultsFromJson = data;
        resultsLength = resultsFromJson.length;
      });
      //print('PRINTING DATA FROM FETCHDATAFROMAPI');
      // print(resultsFromJson);
      // searchLength = data.length;
      yield data;
    } catch (e) {
      print('Algo deu errado! $e');
    }
  }

  Future<void> _openUrl(urlToLaunch) async {
    final Uri url = Uri.parse(urlToLaunch);

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
      webOnlyWindowName: "_blank",
    )) {
      throw 'Não foi possível exibir o site! Erro: $url';
    }
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
    if (ModalRoute.of(context)!.settings.arguments != null) {
      getSearchValue(ModalRoute.of(context)!.settings.arguments as String);
      getResults = true;
    } else {
      getSearchValue('');
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                    IconButton(
                        tooltip: 'Ir para a página inicial do Bug Search',
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
                        icon: const BSLogo()),
                    Text(
                      ' |',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    CustomSearchBar(
                        searchController: _searchController,
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            Navigator.pushNamed(context, 'search',
                                arguments: value);
                            _searchController.clear;
                          } else {
                            return;
                          }
                        },
                        onPress: () {
                          if (_searchController.text.isNotEmpty) {
                            Navigator.pushNamed(context, 'search',
                                arguments: _searchController.text);
                            _searchController.clear;
                          } else {
                            return;
                          }
                        },
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
              mainAxisSize: MainAxisSize.max,
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
                searchKey.isNotEmpty
                    ? Text.rich(
                        TextSpan(
                          text: 'Aproximadamente ',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                          children: [
                            TextSpan(
                              text: '${resultsLength.toString()} ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    // fontSize: 14,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                            TextSpan(
                              text:
                                  'resultados encontrados para: ${searchKey.toString()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      )
                    : Text(
                        'Insira um termo para pesquisar',
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

          const SizedBox(height: 30),

          // ListView //
          StreamBuilder(
            stream: fetchDataFromAPI(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                final resultsFromJson = snapshot.data;
                return resultsFromJson.isNotEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.72,
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: ListView.builder(
                          itemCount: resultsFromJson.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  TextButton(
                                    onHover: (value) {
                                      setState(() {
                                        isHovered = value;
                                      });
                                    },
                                    style: Theme.of(context)
                                        .textButtonTheme
                                        .style
                                        ?.copyWith(
                                          padding: MaterialStateProperty.all<
                                              EdgeInsets>(EdgeInsets.zero),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            Theme.of(context)
                                                .colorScheme
                                                .surface,
                                          ),
                                          overlayColor:
                                              MaterialStateProperty.all<Color>(
                                            Theme.of(context)
                                                .colorScheme
                                                .surface,
                                          ),
                                        ),
                                    onPressed: () async {
                                      await _openUrl(
                                          snapshot.data[index]['link']);
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              radius: 14,
                                              child: Text(
                                                  snapshot.data[index]['title']
                                                          .toString()
                                                          .isNotEmpty
                                                      ? '${snapshot.data[index]['title'].toString().substring(0, 1).toUpperCase()}, ${snapshot.data[index]['title'].toString().substring(1, 2).toUpperCase()}'
                                                      : 'N/A',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface,
                                                      )),
                                            ),
                                            const SizedBox(width: 10),
                                            SizedBox(
                                              child: Text(
                                                snapshot.data[index]['link']
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurfaceVariant,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        SizedBox(
                                          child: Text(
                                            snapshot.data[index]['title']
                                                        .toString() !=
                                                    'null'
                                                ? snapshot.data[index]['title']
                                                    .toString()
                                                : 'N/A',
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    child: Text(
                                      snapshot.data[index]['description']
                                                  .toString() !=
                                              'null'
                                          ? snapshot.data[index]['description']
                                              .toString()
                                          : 'N/A',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurfaceVariant,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Text(
                          'Nenhum resultado encontrado',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                        ),
                      );
              } else {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
