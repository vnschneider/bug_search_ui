import 'package:bug_search/src/models/bs_logo_mobile.dart';
import 'package:bug_search/src/models/custom_searchbar_mobile.dart';
import 'package:flutter/material.dart';

import '../../../functions/get_summary.dart';

class BugSearchUIMobile extends StatefulWidget {
  const BugSearchUIMobile({super.key});

  @override
  State<BugSearchUIMobile> createState() => _BugSearchUIMobileState();
}

class _BugSearchUIMobileState extends State<BugSearchUIMobile> {
  final TextEditingController _searchController = TextEditingController();
  int indexedPages = 0;
  int indexedTerms = 0;

  @override
  void initState() {
    fetchDataFromSummary();
    super.initState();
  }

  Future fetchDataFromSummary() async {
    List indexedValues = await fetchDataSumary(
        'http://apiv2-bugsearch.eastus.cloudapp.azure.com/summary');

    indexedPages = indexedValues[0];
    indexedTerms = indexedValues[1];

    //print(indexedValues);
    return indexedValues;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchDataFromSummary(),
        builder: (context, snapshot) {
          if (indexedPages != 0 && indexedTerms != 0) {
            return SingleChildScrollView(
              child:
                  //BODY//
                  SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //BRANDING//
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Hero(
                                    tag: 'logo',
                                    child: BSLogoMobile(fontsize: 40),
                                  ),
                                  Text(
                                    '/ ',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(
                                          fontSize: 30,
                                        ),
                                  ),
                                  Text(
                                    'Bug Search',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 40,
                                        ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
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
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: 'Mais de ',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                                children: [
                                  TextSpan(
                                    text: indexedPages.toString() != 'null'
                                        ? indexedPages.toString()
                                        : 'N/A',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant,
                                        ),
                                  ),
                                  TextSpan(
                                    text: ' sites indexados, e mais de ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                text: indexedTerms.toString() != 'null'
                                    ? indexedTerms.toString()
                                    : 'N/A',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                                children: [
                                  TextSpan(
                                    text: ' termos no dicionário.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
