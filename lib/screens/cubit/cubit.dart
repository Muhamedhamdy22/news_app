import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/core/internet_checker.dart';
import 'package:news_app/models/news_response.dart';
import 'package:news_app/models/sources_responce.dart';
import 'package:news_app/repository/local/home_local_repo.dart';
import 'package:news_app/repository/remote/home_remote_repo.dart';
import 'package:news_app/repository/remote/home_remote_repo_impl.dart';
import 'package:news_app/screens/cubit/states.dart';

@injectable
class HomeCubit extends Cubit<HomeStates> {
  HomeRemoteRepo remoteRepo;
  HomeLocalRepo localRepo;

  HomeCubit(this.remoteRepo, this.localRepo) : super(HomeInit());

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
      NewsResponse? newsResponse = InternetConnectivity().isConnected
          ? await remoteRepo.getNewsData(sourceId)
          : await localRepo.getNewsData(sourceId);
      articles = newsResponse?.articles ?? [];
      emit(GetNewsSuccessState());
    } catch (e) {
      emit(GetSourcesErrorState());
    }
  }

  Future<void> getSources(String categoryId) async {
    emit(GetSourcesLoadingState());
    try {
      SourcesResponse ? sourcesResponse = InternetConnectivity().isConnected
          ? await remoteRepo.getSources(categoryId)
          : await localRepo.getSources(categoryId);
      sources = sourcesResponse?.sources ?? [];
      emit(GetSourcesSuccessState());
      getNewsData(sources[selectedIndex].id ?? "");
    } catch (e) {
      emit(GetSourcesErrorState());
    }
  }
}
