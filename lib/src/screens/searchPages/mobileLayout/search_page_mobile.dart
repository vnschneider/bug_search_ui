// ignore_for_file: avoid_print
import 'package:bug_search/src/models/custom_searchbar_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../functions/get_results.dart';
import '../../../functions/url_launcher.dart';

class SearchPageMobile extends StatefulWidget {
  const SearchPageMobile({super.key});

  @override
  State<SearchPageMobile> createState() => _SearchPageMobileState();
}

class _SearchPageMobileState extends State<SearchPageMobile> {
  String searchKey = '';
  double searchDensityValue = 100;
  double sliderValue = 20;

  bool getResults = false;
  bool onSearch = true;
  int resultsLength = 0;
  final ScrollController _scrollController = ScrollController();
  final _searchController = TextEditingController();
  List<dynamic> resultsFromJson = [];

  @override
  void initState() {
    //fetchDataFromAPI();

    super.initState();
  }

  @override
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      getSearchValue(ModalRoute.of(context)!.settings.arguments as String);
      getResults = true;
    } else {
      getSearchValue('');
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.surfaceVariant,
        surfaceTintColor: Theme.of(context).colorScheme.onSurface,
        shadowColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        toolbarHeight: 180,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                tooltip: 'Ir para a página inicial do Bug Search',
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                style: Theme.of(context).textButtonTheme.style?.copyWith(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                icon: Hero(
                  tag: 'logo',
                  child: Text(
                    'Bug Search',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Hero(
                tag: 'searchBar',
                child: CustomSearchBarMobile(
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
                    height: MediaQuery.of(context).size.height * 0.045,
                    width: MediaQuery.of(context).size.width * 0.9),
              ),
              Slider(
                inactiveColor: Theme.of(context).colorScheme.surface,
                activeColor: Theme.of(context).colorScheme.primary,
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
              Divider(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    searchKey.isEmpty
                        ? 'Insira um termo para buscar'
                        : resultsLength == 0
                            ? 'Nenhum resultado encontrado para: $searchKey'
                            : '$resultsLength resultados para: $searchKey',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
              // const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //const SizedBox(height: 16),
          FutureBuilder(
            future: fetchDataFromAPI(),
            builder: (context, snapshot) {
              if (resultsFromJson.isNotEmpty) {
                //final resultsFromJson = snapshot.data;
                return resultsFromJson.isNotEmpty
                    ? Flexible(
                        child: Scrollbar(
                          controller: _scrollController,
                          child: ListView.builder(
                            controller: _scrollController,
                            // scrollDirection: Axis.vertical,
                            itemCount: resultsFromJson.length,
                            //  shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                child: TextButton(
                                  style: Theme.of(context)
                                      .textButtonTheme
                                      .style
                                      ?.copyWith(
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(EdgeInsets.zero),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Theme.of(context).colorScheme.surface,
                                        ),
                                        overlayColor:
                                            MaterialStateProperty.all<Color>(
                                          Theme.of(context).colorScheme.surface,
                                        ),
                                      ),
                                  onPressed: () async {
                                    await openUrl(
                                        resultsFromJson[index]['link']);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      SizedBox(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          textDirection: TextDirection.ltr,
                                          children: [
                                            SvgPicture.asset(
                                                'assets/bs_logo.svg',
                                                height: 24,
                                                width: 24,
                                                semanticsLabel:
                                                    'Bug Search Logo'),
                                            const SizedBox(width: 4),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.8,
                                                  child: Text(
                                                    resultsFromJson[index]
                                                                    ['link']
                                                                .toString() !=
                                                            'null'
                                                        ? resultsFromJson[index]
                                                                ['link']
                                                            .toString()
                                                        : 'Sem link',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium
                                                        ?.copyWith(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Theme.of(
                                                                  context)
                                                              .colorScheme
                                                              .onSurfaceVariant,
                                                        ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.8,
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
                                                        .displaySmall
                                                        ?.copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: Text(
                                          resultsFromJson[index]['description']
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
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
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
                                fontSize: 14,
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
