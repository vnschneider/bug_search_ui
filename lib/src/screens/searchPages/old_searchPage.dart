// NO RESPONSIVE SCREEN //
// ignore_for_file: file_names, avoid_print
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:bug_search/src/functions/get_results.dart';
import 'package:bug_search/src/models/bsLogo.dart';
import 'package:bug_search/src/models/searchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../functions/url_launcher.dart';
import '../../models/switch_button.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'dart:async';

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
  bool onSearch = true;
  bool isHovered = false;
  List<dynamic> resultsFromJson = [];
  int resultsLength = 0;
  String searchKey = '';
  double sliderValue = 20;
  double searchDensityValue = 100;

  final _searchController = TextEditingController();
  final ScrollController _scrollBarController = ScrollController();
  late ScrollController _scrollController;

  @override
  void initState() {
    //  fetchDataFromAPI();
    // initialize scroll controllers
    _scrollController = ScrollController();
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

  Future fetchDataFromAPI() async {
    if (onSearch) {
      try {
        List data = await fetchData2(
                'http://apiv2-bugsearch.eastus.cloudapp.azure.com/search?q=$searchKey&l=${searchDensityValue.toString()}')
            .whenComplete(() => onSearch = false);

        resultsFromJson = data;
        setState(() {
          resultsLength = resultsFromJson.length;
        });

        //print('PRINTING DATA FROM FETCHDATAFROMAPI');
        // print(resultsFromJson);
        // searchLength = data.length;
        return resultsFromJson;
      } catch (e) {
        print('Algo deu errado! $e');
      }
    } else {
      onSearch = true;
    }
  }

  void _toggleTap() {
    if (mounted) {
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
  }

  void _toggleTap1() {
    if (mounted) {
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
  }

  void _toggleTap2() {
    if (mounted) {
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
  }

  void _toggleTap3() {
    if (mounted) {
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
      body: WebSmoothScroll(
        controller: _scrollController,
        scrollOffset: 100, // additional offset to users scroll input
        animationDuration:
            500, // duration of animation of scroll in milliseconds
        curve: Curves.easeInOutCirc, // curve of the animation
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          controller: _scrollController,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              Hero(
                                tag: 'logo',
                                child: IconButton(
                                    tooltip:
                                        'Ir para a página inicial do Bug Search',
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/');
                                    },
                                    style: Theme.of(context)
                                        .textButtonTheme
                                        .style
                                        ?.copyWith(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                        ),
                                    icon: const Hero(
                                        tag: 'logo', child: BSLogo())),
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
                                    height: 48,
                                    width: MediaQuery.of(context).size.width *
                                        0.4),
                              ),
                              Slider(
                                inactiveColor:
                                    Theme.of(context).colorScheme.surface,
                                activeColor:
                                    Theme.of(context).colorScheme.primary,
                                value: sliderValue,
                                min: 20,
                                max: 100,
                                divisions: 4,
                                label: "Densidade da busca: $sliderValue%",
                                onChanged: (newsearchDensityValue) {
                                  setState(() {
                                    onSearch = true;
                                  });
                                  if (newsearchDensityValue == 20) {
                                    searchDensityValue = 100;
                                    sliderValue = 20;
                                  } else if (newsearchDensityValue == 40) {
                                    searchDensityValue = 250;
                                    sliderValue = 40;
                                  } else if (newsearchDensityValue == 60) {
                                    searchDensityValue = 500;
                                    sliderValue = 60;
                                  } else if (newsearchDensityValue == 80) {
                                    searchDensityValue = 750;
                                    sliderValue = 80;
                                  } else {
                                    searchDensityValue = 1000;
                                    sliderValue = 100;
                                  }
                                },
                              ),
                            ],
                          ),
                          Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Expanded(child: SizedBox()),
                                Hero(
                                  tag: 'button',
                                  child: IconButton(
                                    tooltip: 'Favoritos',
                                    hoverColor:
                                        Theme.of(context).colorScheme.secondary,
                                    highlightColor:
                                        Theme.of(context).colorScheme.tertiary,
                                    isSelected: onClick,
                                    selectedIcon: const Icon(
                                        BootstrapIcons.bookmark_fill),
                                    onPressed: () {
                                      setState(() {
                                        onClick = !onClick;
                                      });
                                    },
                                    icon: const Icon(BootstrapIcons.bookmark),
                                  ),
                                ),
                                const SizedBox(width: 40),
                                Hero(
                                  tag: 'switch',
                                  child: customSwitchButton(
                                      (p0) => {
                                            setState(() {
                                              isSwitched = p0;
                                            })
                                          },
                                      isSwitched,
                                      48,
                                      88),
                                ),
                              ],
                            ),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    fontWeight: _isTapped
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: _isTapped
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: _toggleTap1,
                            child: Text(
                              'Imagens',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    fontWeight: _isTapped1
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: _isTapped1
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: _toggleTap2,
                            child: Text(
                              'Vídeos',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    fontWeight: _isTapped2
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: _isTapped2
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: _toggleTap3,
                            child: Text(
                              'Documentos',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    fontWeight: _isTapped3
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: _isTapped3
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
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
                          searchKey.isEmpty
                              ? Text(
                                  'Insira um termo para pesquisar',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                        fontWeight: FontWeight.w600,
                                      ),
                                )
                              : searchKey.isNotEmpty
                                  ? Text.rich(
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
                                        children: [
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
                                  : resultsFromJson.isEmpty
                                      ? Text(
                                          'Nenhum resultado encontrado para: ${searchKey.toString()}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurfaceVariant,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        )
                                      : const SizedBox(width: 1),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // ListView //
                FutureBuilder(
                  future: fetchDataFromAPI(),
                  builder: (context, snapshot) {
                    if (resultsFromJson.isNotEmpty) {
                      return resultsFromJson.isNotEmpty
                          ? Flexible(
                              child: Scrollbar(
                                controller: _scrollBarController,
                                child: ListView.builder(
                                  controller: _scrollBarController,
                                  itemCount: resultsFromJson.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          const SizedBox(height: 20),
                                          TextButton(
                                            style: Theme.of(context)
                                                .textButtonTheme
                                                .style
                                                ?.copyWith(
                                                  padding: MaterialStateProperty
                                                      .all<EdgeInsets>(
                                                          EdgeInsets.zero),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .surface,
                                                  ),
                                                  overlayColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .surface,
                                                  ),
                                                ),
                                            onPressed: () async {
                                              await openUrl(
                                                  resultsFromJson[index]
                                                      ['link']);
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
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    SvgPicture.asset(
                                                        'assets/bs_logo.svg',
                                                        height: 26,
                                                        width: 26,
                                                        semanticsLabel:
                                                            'Bug Search Logo'),
                                                    const SizedBox(width: 10),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.6,
                                                      child: Text(
                                                        resultsFromJson[index]
                                                                        ['link']
                                                                    .toString() !=
                                                                'null'
                                                            ? resultsFromJson[
                                                                        index]
                                                                    ['link']
                                                                .toString()
                                                            : 'Sem link',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium
                                                            ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onSurfaceVariant,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 8),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.7,
                                                  child: Text(
                                                    resultsFromJson[index]
                                                                    ['title']
                                                                .toString() !=
                                                            'null'
                                                        ? resultsFromJson[index]
                                                                ['title']
                                                            .toString()
                                                        : 'Sem título',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16,
                                                          color:
                                                              Theme.of(context)
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            child: Text(
                                              resultsFromJson[index]
                                                              ['description']
                                                          .toString() !=
                                                      'null'
                                                  ? resultsFromJson[index]
                                                          ['description']
                                                      .toString()
                                                  : 'Sem descrição',
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
                                          const SizedBox(height: 20),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : Expanded(
                              child: Center(
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
          ),
        ),
      ),
    );
  }
}
