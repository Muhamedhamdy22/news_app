import 'package:dio/dio.dart';
import 'package:news_app/core/constants.dart';
import 'package:news_app/models/news_response.dart';
import 'package:news_app/models/sources_responce.dart';

class ApiManager {
 static final dio = Dio();

 // static Future<sourcesResponse?> getSources() async {
 //    try {
 //      Response response = await dio.get(
 //        "$BASEURL/v2/top-headlines/sources?apiKey=$APIKEY",
 //      );
 //
 //      sourcesResponse SourcesResponse = sourcesResponse.fromJson(response.data);
 //      return SourcesResponse;
 //    } catch (e) {
 //      throw Exception("something Went Wrong");
 //    }
 //  }

  // static Future<NewsResponse?>getNewsData (String sourceId) async{
  //  try {
  //    Response response = await dio.get(
  //      "$BASEURL/v2/everything?sources=$sourceId&apiKey=$APIKEY",
  //    );
  //    NewsResponse newsResponse = NewsResponse.fromJson(response.data);
  //    return newsResponse;
  //  }catch (e){
  //    throw Exception("something Went Wrong");
  //  }
  // }
}
