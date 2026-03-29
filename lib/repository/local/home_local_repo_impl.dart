import 'package:injectable/injectable.dart';
import 'package:news_app/core/cache_helper.dart';
import 'package:news_app/models/news_response.dart';
import 'package:news_app/models/sources_responce.dart';
import 'package:news_app/repository/local/home_local_repo.dart';


@Injectable(as: HomeLocalRepo)
class HomeLocalRepoImpl implements HomeLocalRepo {
  @override
  Future<NewsResponse?> getNewsData(String sourceId) async{
    return await CacheHelper.getNewsResponse(sourceId);
  }

  @override
  Future<SourcesResponse?> getSources(String catId) async {
    return await CacheHelper.getSourcesResponse(catId);
  }
  
  
}