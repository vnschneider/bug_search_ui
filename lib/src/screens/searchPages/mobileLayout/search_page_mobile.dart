// ignore_for_file: avoid_print
import 'package:bug_search/src/models/bs_logo_mobile.dart';
import 'package:bug_search/src/models/custom_searchbar_mobile.dart';
import 'package:flutter/material.dart';
import '../../../functions/get_results.dart';

class SearchPageMobile extends StatefulWidget {
  const SearchPageMobile({super.key});

  @override
  State<SearchPageMobile> createState() => _SearchPageMobileState();
}

class _SearchPageMobileState extends State<SearchPageMobile> {
  String searchKey = '';
  double searchDensityValue = 20;
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

  Stream fetchDataFromAPI() async* {
    try {
      List data = await fetchData2(
          'http://40.76.148.166/search?q=$searchKey&l=${searchDensityValue.toString()}');

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
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                icon: const Hero(
                  tag: 'logo',
                  child: BSLogoMobile(fontsize: 34),
                ),
              ),
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
                    width: MediaQuery.of(context).size.width * 0.6),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  searchKey.isEmpty
                      ? 'Insira um termo para buscar'
                      : resultsLength == 0
                          ? 'Nenhum resultado para: $searchKey'
                          : '$resultsLength resultados para: $searchKey',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                Divider(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 10),
                //const SizedBox(height: 16),
                StreamBuilder(
                  stream: fetchDataFromAPI(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        //final resultsFromJson = snapshot.data;
                        return resultsFromJson.isNotEmpty
                            ? SizedBox(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: resultsFromJson.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                              resultsFromJson[index]['link']
                                                          .toString() !=
                                                      'null'
                                                  ? resultsFromJson[index]
                                                          ['link']
                                                      .toString()
                                                  : 'N/A',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium
                                                  ?.copyWith(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            subtitle: Text(
                                              resultsFromJson[index]['title']
                                                          .toString() !=
                                                      'null'
                                                  ? resultsFromJson[index]
                                                          ['title']
                                                      .toString()
                                                  : 'N/A',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall
                                                  ?.copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurfaceVariant,
                                                  ),
                                            ),
                                          ),

                                          /*SizedBox(
                                            height: 200,
                                            child: Image.network(
                                              resultsFromJson[index]['imageUrl']
                                                          .toString() !=
                                                      'null'
                                                  ? resultsFromJson[index]
                                                          ['imageUrl']
                                                      .toString()
                                                  : 'https://via.placeholder.com/150',
                                              fit: BoxFit.cover,
                                            ),
                                          ),*/
                                          const SizedBox(height: 8),
                                          SizedBox(
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
