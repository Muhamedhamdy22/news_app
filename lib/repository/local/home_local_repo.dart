import '../../models/news_response.dart';
import '../../models/sources_responce.dart';

abstract class HomeLocalRepo {

  Future<SourcesResponse?> getSources(String catId);
  Future<NewsResponse?> getNewsData(String sourceId);
}