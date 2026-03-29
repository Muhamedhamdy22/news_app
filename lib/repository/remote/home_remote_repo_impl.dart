import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/core/api_manager.dart';
import 'package:news_app/core/cache_helper.dart';
import 'package:news_app/core/constants.dart' as AppConstants;
import 'package:news_app/models/news_response.dart';
import 'package:news_app/models/sources_responce.dart';
import 'package:news_app/repository/remote/home_remote_repo.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../models/news_response.dart' as NewsRespons;


@Injectable(as: HomeRemoteRepo)
class HomeRemoteRepoImpl extends  HomeRemoteRepo{
  ApiManager apiManager;

  HomeRemoteRepoImpl(this.apiManager);

  @override
  Future<NewsResponse> getNewsData(String sourceId) async {
    try {
      Response response = await apiManager.get(
        "/v2/everything",
        queryParameters: {"sources": sourceId},
      );
      NewsResponse newsResponse = NewsResponse.fromJson(response.data);
      await CacheHelper.saveNewsBox(newsResponse, sourceId);
      return newsResponse;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<SourcesResponse> getSources(String catId) async {
    try {
      Response response = await apiManager.get("/v2/sources?category=$catId");
      SourcesResponse sourcesResponse = SourcesResponse.fromJson(response.data);
      await CacheHelper.saveSourcesBox(sourcesResponse, catId);
      return sourcesResponse;
    } catch (e) {
      throw Exception();
    }
  }
}
