import 'package:news_app/models/news_response.dart';
import 'package:news_app/models/sources_responce.dart';

abstract class HomeRemoteRepo {

 Future<SourcesResponse> getSources(String catId);
 Future<NewsResponse> getNewsData(String sourceId);
}