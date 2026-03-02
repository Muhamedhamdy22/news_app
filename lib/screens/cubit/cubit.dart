import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants.dart';
import 'package:news_app/models/news_response.dart';
import 'package:news_app/models/sources_responce.dart';
import 'package:news_app/screens/cubit/states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInit());

  static HomeCubit get(context) => BlocProvider.of(context);
  int selectedIndex = 0;

  onTapChanged(int index) {
    selectedIndex = index;
    emit(HomeOnTapChanged());
    getNewsData(sources[selectedIndex].id??"");
  }
  static final dio = Dio();
  List<Sources> sources = [];
  List<Articles> articles = [];

  Future<void> getNewsData(String sourceId) async {
    emit(GetNewsLoadingState());
    try {
      Response response = await dio.get(
        "$BASEURL/v2/everything?sources=$sourceId&apiKey=$APIKEY",
      );
      NewsResponse newsResponse = NewsResponse.fromJson(response.data);
      articles = newsResponse.articles ?? [];
      emit(GetNewsSuccessState());
    } catch (e) {
      emit(GetSourcesErrorState());
    }
  }

  Future<void> getSources() async {
    emit(GetSourcesLoadingState());
    try {
      Response response = await dio.get(
        "$BASEURL/v2/top-headlines/sources?apiKey=$APIKEY",
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
