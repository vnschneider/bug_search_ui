// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:core';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchData2(String url) async {
  // Replace with your actual URL

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    var result = <Map<String, dynamic>>[];

    //print('PRINTING DATA FromAPI - JSON');
    //print(data);
    for (var item in data["searchResults"]) {
      result.add({
//'index': item['index'],
       'pts': item['pts'],
        'link': item['link'],
        'title': item['title'],
        'description': item['description'],
        'favicon': item['favicon'],
      });
    }
    //print('PRINTING DATA FromAPI - RESULT');
    //print(result);

    return result;
  } else {
    throw Exception('Failed to fetch data');
  }
}
