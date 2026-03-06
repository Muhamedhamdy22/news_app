import 'package:dio/dio.dart';
import 'package:news_app/core/constants.dart' as AppConstants;
import 'package:news_app/core/dio_interceptor.dart';
import 'package:news_app/models/news_response.dart';
import 'package:news_app/models/sources_responce.dart';
import 'package:news_app/repository/home_repo.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HomeRemoteRepo implements HomeRepo{
  static final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.BASEURL,
      headers: {"x-api-Key": AppConstants.APIKEY},
    ),
  );
  HomeRemoteRepo() {
    dio.interceptors.add(PrettyDioLogger(request: true, responseBody: true));
    dio.interceptors.add(MyInterceptor());
  }
  @override
  Future<NewsResponse> getNewsData(String sourceId) async{
    try {
      Response response =await dio.get("/v2/everything?sources=$sourceId");
      return NewsResponse.fromJson(response.data);
    }catch (e){
      throw Exception();
    }
  }

  @override
  Future<sourcesResponse> getSources(String catId) async{
    try {
      Response response =await dio.get("/v2/sources?category=$catId");
      return sourcesResponse.fromJson(response.data);
    }catch (e){
      throw Exception();
    }
  }
}