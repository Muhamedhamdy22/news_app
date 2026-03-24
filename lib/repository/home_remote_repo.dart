import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/core/api_manager.dart';
import 'package:news_app/core/constants.dart' as AppConstants;
import 'package:news_app/models/news_response.dart';
import 'package:news_app/models/sources_responce.dart';
import 'package:news_app/repository/home_repo.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


@Injectable(as: HomeRepo)
class HomeRemoteRepo extends HomeRepo {
  ApiManager apiManager;

  HomeRemoteRepo(this.apiManager);

  @override
  Future<NewsResponse> getNewsData(String sourceId) async {
    try {
      Response response = await apiManager.get(
        "/v2/everything",
        queryParameters: {"sources": sourceId},
      );
      return NewsResponse.fromJson(response.data);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<SourcesResponse> getSources(String catId) async {
    try {
      Response response = await apiManager.get("/v2/sources?category=$catId");
      return SourcesResponse.fromJson(response.data);
    } catch (e) {
      throw Exception();
    }
  }
}
