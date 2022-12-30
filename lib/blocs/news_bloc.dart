
import 'dart:async';

import 'package:flutter_newsapp/services/api_services.dart';

import '../model/news_model.dart';
enum NewsAction { Fetch, Delete}
class NewsBloc {
  final _stateStreamController = StreamController <List<Article>>();
  StreamSink<List<Article>> get _newsSink => _stateStreamController.sink;
  Stream<List<Article>> get newsStream => _stateStreamController.stream;

  final _eventStreamController = StreamController <NewsAction>();
  StreamSink<NewsAction> get eventSink => _eventStreamController.sink;
  Stream<NewsAction> get _eventStream => _eventStreamController.stream;

  NewsBloc() {
    _eventStream.listen((event) async {
      if(event == NewsAction.Fetch){

        try {
          var news = await API_Manager().getNews();
          if (news != null) {
            _newsSink.add(news.articles);
          } else {
            _newsSink.addError("Something went wrong...");
          }
        } on Exception catch (e) {
          _newsSink.addError(e);
        }
      }
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }

}