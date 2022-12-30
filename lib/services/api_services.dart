import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/news_model.dart';
// ignore: camel_case_types
class API_Manager {
  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;
    try {
      var response = await client.get(Uri.parse('https://newsapi.org/v2/everything?domains=wsj.com&apiKey=aadaf284ea6c4ab3bb6c32c64c961375'));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = NewsModel.fromJson(jsonMap);
      }
    } catch (e) {
      return newsModel;
    }

    return newsModel;
  }
}