import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/theme/base_theme.dart';
import 'package:news_app/core/theme/bloc/state.dart';

import '../dark_theme.dart';
import '../light_theme.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitState());
  static ThemeCubit get(context) => BlocProvider.of(context);

  BaseTheme baseTheme = LightTheme();
  changeTheme(){
    emit(ThemeInitState());
    if(baseTheme is LightTheme){
      baseTheme = DarkTheme();
    }else{
      baseTheme = LightTheme();
    }
    emit(ThemeChangedState());
  }

}