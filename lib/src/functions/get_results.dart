import 'dart:convert';

import 'package:http/http.dart' as http;

class MyJsonData {
  final int index;
  final String guid;
  final String link;
  final String title;
  final String description;
  final String favicon;

  MyJsonData({
    required this.index,
    required this.guid,
    required this.link,
    required this.title,
    required this.description,
    required this.favicon,
  });

  factory MyJsonData.fromJson(Map<String, dynamic> json) {
    return MyJsonData(
      index: json['index'],
      guid: json['guid'],
      link: json['link'],
      title: json['title'],
      description: json['description'],
      favicon: json['favicon'],
    );
  }
}

Future<List<MyJsonData>> fetchData(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final List<dynamic> jsonDataList = json.decode(response.body);
    return jsonDataList.map((e) => MyJsonData.fromJson(e)).toList();
  } else {
    throw Exception('Failed to fetch data');
  }
}

Future  getJsonFile(Uri url) async {
  // Define the URL to retrieve JSON data from

  // Retrieve the JSON data using the 'http' package
  var response = await http.get(url);

  // Convert the JSON data into a Map object
  var data = jsonDecode(response.body);

  // Filter the data and create a new list with only certain fields
  var result = <Map<String, dynamic>>[];
  for (var item in data) {
    result.add({
      'index': item['index'],
      'guid': item['guid'],
      'link': item['link'],
      'title': item['title'],
      'description': item['description'],
      'favicon': item['favicon']
    });
  }

  // Print the resulting list
  print(result);
}
