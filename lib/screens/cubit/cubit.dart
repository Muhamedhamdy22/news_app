import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants.dart';
import 'package:news_app/core/constants.dart' as AppConstants;
import 'package:news_app/core/dio_interceptor.dart';
import 'package:news_app/models/news_response.dart';
import 'package:news_app/models/sources_responce.dart';
import 'package:news_app/screens/cubit/states.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInit()) {
    dio.interceptors.add(PrettyDioLogger(request: true, responseBody: true));
    dio.interceptors.add(MyInterceptor());
  }

  static HomeCubit get(context) => BlocProvider.of(context);
  int selectedIndex = 0;

  onTapChanged(int index) {
    selectedIndex = index;
    emit(HomeOnTapChanged());
    getNewsData(sources[selectedIndex].id ?? "");
  }

  static final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.BASEURL,
      headers: {"x-api-Key": AppConstants.APIKEY},
    ),
  );
  List<Sources> sources = [];
  List<Articles> articles = [];

  Future<void> getNewsData(String sourceId) async {
    emit(GetNewsLoadingState());
    try {
      Response response = await dio.get(
        "/v2/everything?sources=$sourceId",
      );
      NewsResponse newsResponse = NewsResponse.fromJson(response.data);
      articles = newsResponse.articles ?? [];
      emit(GetNewsSuccessState());
    } catch (e) {
      emit(GetSourcesErrorState());
    }
  }

  Future<void> getSources(String categoryId) async {
    emit(GetSourcesLoadingState());
    try {
      Response response = await dio.get(
        "/v2/top-headlines/sources?&category=$categoryId",
      );

      sourcesResponse SourcesResponse = sourcesResponse.fromJson(response.data);
      sources = SourcesResponse.sources ?? [];
      emit(GetSourcesSuccessState());
      getNewsData(sources[selectedIndex].id ?? "");
    } catch (e) {
      emit(GetSourcesErrorState());
    }
  }
}
