// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:core';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchDataSumary(String url) async {
  // Replace with your actual URL

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // Decodificando o JSON em um objeto Dart
    Map<String, dynamic> result = json.decode(response.body);

    // Acessando o valor de "indexedPages"
    int indexedPages = result["summary"]["indexedPages"];

    // Acessando o valor de "indexedTerms"
    int indexedTerms = result["summary"]["indexedTerms"];

    // Imprimindo os valores
    // print('PRINTING DATA FromAPI - RESULT');
    //print("Número de páginas indexadas: $indexedPages");
    //  print("Número de termos indexados: $indexedTerms");
    // print(result);
    // Retornando uma lista com os dois valores
    return [indexedPages, indexedTerms];
  } else {
    throw Exception('Failed to fetch data');
  }
}
