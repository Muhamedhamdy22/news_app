import 'package:news_app/models/news_response.dart';
import 'package:news_app/models/sources_responce.dart';
import 'package:news_app/repository/home_repo.dart';

class HomeLocalRepo implements HomeRepo{
  @override
  Future<NewsResponse> getNewsData(String sourceId) {
    // TODO: implement getNewsData
    throw UnimplementedError();
  }

  @override
  Future<sourcesResponse> getSources(String catId) {
    // TODO: implement getSources
    throw UnimplementedError();
  }
}