import 'dart:convert';

import 'package:news_app/models/news_model.dart';
import 'package:http/http.dart' as http;

class GetNewsApi {
  static const baseUrl = 'https://newsapi.org/v2';
  final String apiKey;

  GetNewsApi(this.apiKey);

  Future<NewsModel> getNewsApi(String topicName) async {
    var url = Uri.parse('$baseUrl/everything?q=$topicName&apiKey=$apiKey');
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);

    print("Reponse Status: ${response.statusCode}");
    print("Reponse Status: ${responseBody}");

    if (response.statusCode == 200) {
      return NewsModel.fromJson(responseBody);
    } else {
      throw Exception('Failed to retrieve news :(');
    }
  }
}
