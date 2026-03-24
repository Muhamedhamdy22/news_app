import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/models/news_response.dart';
import 'package:news_app/models/sources_responce.dart';
import 'package:news_app/repository/home_repo.dart';
import 'package:news_app/screens/cubit/states.dart';

@injectable
class HomeCubit extends Cubit<HomeStates> {
  HomeRepo repo;
  HomeCubit(this.repo) : super(HomeInit());

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);
  int selectedIndex = 0;

  void onTapChanged(int index) {
    selectedIndex = index;
    emit(HomeOnTapChanged());
    getNewsData(sources[selectedIndex].id ?? "");
  }


  List<Sources> sources = [];
  List<Articles> articles = [];

  Future<void> getNewsData(String sourceId) async {
    emit(GetNewsLoadingState());
    try {
      NewsResponse newsResponse =await repo.getNewsData(sourceId);
      articles = newsResponse.articles ?? [];
      emit(GetNewsSuccessState());
    } catch (e) {
      emit(GetSourcesErrorState());
    }
  }

  Future<void> getSources(String categoryId) async {
    emit(GetSourcesLoadingState());
    try {
      SourcesResponse sourcesResponse = await repo.getSources(categoryId);
      sources = sourcesResponse.sources ?? [];
      emit(GetSourcesSuccessState());
      getNewsData(sources[selectedIndex].id ?? "");
    } catch (e) {
      emit(GetSourcesErrorState());
    }
  }
}
