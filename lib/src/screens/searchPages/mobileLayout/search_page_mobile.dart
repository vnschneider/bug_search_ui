// ignore_for_file: avoid_print
import 'package:bug_search/src/models/custom_searchbar_mobile.dart';
import 'package:flutter/material.dart';
import '../../../functions/get_results.dart';
import '../../../functions/url_launcher.dart';

class SearchPageMobile extends StatefulWidget {
  const SearchPageMobile({super.key});

  @override
  State<SearchPageMobile> createState() => _SearchPageMobileState();
}

class _SearchPageMobileState extends State<SearchPageMobile> {
  String searchKey = '';
  double searchDensityValue = 20;
  bool searchDensityChanged = false;
  bool getResults = false;
  int resultsLength = 0;
  final _searchController = TextEditingController();
  List<dynamic> resultsFromJson = [];

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
    try {
      List data = await fetchData2(
          'http://api-bugsearch.eastus.cloudapp.azure.com/search?q=$searchKey&l=${searchDensityValue.toString()}');

      setState(() {
        resultsFromJson = data;
        resultsLength = resultsFromJson.length;
      });
      //print('PRINTING DATA FROM FETCHDATAFROMAPI');
      // print(resultsFromJson);
      // searchLength = data.length;
      return data;
    } catch (e) {
      print('Algo deu errado! $e');
    }
    if (searchDensityChanged == true) {
      setState(() {
        fetchDataFromAPI();
      });
      searchDensityChanged = false;
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
        toolbarHeight: 140,
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
                value: searchDensityValue,
                min: 20,
                max: 100,
                divisions: 4,
                label: "Densidade da busca: $searchDensityValue%",
                onChanged: (newsearchDensityValue) {
                  setState(() {
                    searchDensityValue = newsearchDensityValue;
                    searchDensityChanged = true;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: resultsFromJson.length >= 5
              ? MediaQuery.of(context).size.height * 2
              : resultsFromJson.length >= 10
                  ? MediaQuery.of(context).size.height * 4
                  : resultsFromJson.length >= 15
                      ? MediaQuery.of(context).size.height * 8
                      : MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Divider(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: Text(
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
              ),

              const SizedBox(height: 10),
              //const SizedBox(height: 16),
              FutureBuilder(
                future: fetchDataFromAPI(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    //final resultsFromJson = snapshot.data;
                    return resultsFromJson.isNotEmpty
                        ? SizedBox(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: resultsFromJson.length,
                              shrinkWrap: true,
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
                                      await openUrl(
                                          resultsFromJson[index]['link']);
                                    },
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              textDirection: TextDirection.ltr,
                                              children: [
                                                SizedBox(
                                                  height: 24,
                                                  width: 24,
                                                  child: Image.asset(
                                                      'assets/bs_logo.png',
                                                      fit: BoxFit.cover,
                                                      semanticLabel:
                                                          'Bug Search Logo'),
                                                ),
                                                const SizedBox(width: 4),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      child: Text(
                                                        resultsFromJson[index]
                                                                        ['link']
                                                                    .toString() !=
                                                                'null'
                                                            ? resultsFromJson[
                                                                        index]
                                                                    ['link']
                                                                .toString()
                                                            : 'N/A',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displayMedium
                                                            ?.copyWith(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onSurfaceVariant,
                                                            ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      child: Text(
                                                        resultsFromJson[index][
                                                                        'title']
                                                                    .toString() !=
                                                                'null'
                                                            ? resultsFromJson[
                                                                        index]
                                                                    ['title']
                                                                .toString()
                                                            : 'N/A',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displaySmall
                                                            ?.copyWith(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Theme.of(
                                                                      context)
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Text(
                                              resultsFromJson[index]
                                                              ['description']
                                                          .toString() !=
                                                      'null'
                                                  ? resultsFromJson[index]
                                                          ['description']
                                                      .toString()
                                                  : 'N/A',
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
        ),
      ),
    );
  }
}
