import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:news_app/core/api_manager.dart';
import 'package:news_app/screens/cubit/cubit.dart';
import 'package:news_app/screens/cubit/states.dart';
import 'package:news_app/screens/news_data.dart';
import 'package:news_app/screens/views/categories_view.dart';
import 'package:news_app/screens/views/sources_views.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "HomeScreen";

  HomeScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("News App")),
        body: CategoriesView(),
      ),
    );
  }
}
