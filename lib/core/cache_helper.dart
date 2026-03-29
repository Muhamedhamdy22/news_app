import 'package:hive/hive.dart';
import 'package:news_app/models/news_response.dart';

import '../models/sources_responce.dart';

class CacheHelper {

  static const String _sourcesBoxName = "sourcesBox";
  static const String _newsBoxName = "newsBox";


 static Future<Box<SourcesResponse>> _openSourcesBox() async{
    if(!Hive.isBoxOpen(_sourcesBoxName)){
     return await Hive.openBox<SourcesResponse>(_sourcesBoxName);
    }
    return Hive.box<SourcesResponse>(_sourcesBoxName);
  }

static Future<void> saveSourcesBox(SourcesResponse sourcesResponse , String categoryId) async {
    final box = await _openSourcesBox();
    await box.put("sources-$categoryId", sourcesResponse);
  }

 static Future<SourcesResponse?> getSourcesResponse(String categoryId) async {
    final box = await _openSourcesBox();
    return box.get("sources-$categoryId");
  }

 static Future<void> deleteSourcesResponse(String categoryId) async {
    final box = await _openSourcesBox();
    await box.delete("sources-$categoryId");
  }

  static Future<Box<NewsResponse>> _openNewsBox() async{
    if(!Hive.isBoxOpen(_newsBoxName)){
      return await Hive.openBox<NewsResponse>(_newsBoxName);
    }
    return Hive.box<NewsResponse>(_newsBoxName);
  }

  static Future<void> saveNewsBox(NewsResponse newsResponse , String sourceId) async {
    final box = await _openNewsBox();
    await box.put("news-$sourceId", newsResponse);
  }

  static Future<NewsResponse?> getNewsResponse(String sourceId) async {
    final box = await _openNewsBox();
    return box.get("news-$sourceId");
  }

  static Future<void> deleteNewsResponse(String sourceId) async {
    final box = await _openNewsBox();
    await box.delete("news-$sourceId");
  }
}