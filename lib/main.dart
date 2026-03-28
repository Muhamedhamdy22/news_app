import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/internet_checker.dart';
import 'package:news_app/core/theme/bloc/cubit.dart';
import 'package:news_app/core/theme/bloc/state.dart';
import 'package:news_app/di.dart';
import 'package:news_app/models/news_response_adaptor.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/sources_response_adaptor.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InternetConnectivity().initialize();
  configureDependencies();
  Hive.initFlutter();
  Hive.registerAdapter(SourcesResponseAdapter());
  Hive.registerAdapter(SourcesAdapter());
  Hive.registerAdapter(ArticlesAdapter());
  Hive.registerAdapter(NewsResponseAdapter());

  runApp(
    BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return  MyApp();
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        SplashScreen.routeName: (context) => SplashScreen(),
      },
    );
  }
}
