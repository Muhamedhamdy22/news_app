import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:news_app/core/api_manager.dart';
import 'package:news_app/models/category_modal.dart';
import 'package:news_app/screens/cubit/cubit.dart';
import 'package:news_app/screens/cubit/states.dart';
import 'package:news_app/screens/news_data.dart';
import 'package:news_app/screens/views/app_drawer.dart';
import 'package:news_app/screens/views/categories_view.dart';
import 'package:news_app/screens/views/sources_views.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        drawer: AppDrawer(
          onDrawerSelected: onDrawerClicked,
        ),
        appBar: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          centerTitle: true,
          title: Text(
            selectedCategory == null ? "Home" : selectedCategory!.label,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF171717),
            ),
          ),
        ),
        body: selectedCategory == null
            ? CategoriesView(onCategoryClicked: onCategoryClicked)
            : SourcesViews(ctId: selectedCategory!.id),
      ),
    );
  }
  onDrawerClicked(){
    selectedCategory = null;
    Navigator.pop(context);
    setState(() {});
  }

  CategoryModal? selectedCategory;
  onCategoryClicked(CategoryModal category) {
    selectedCategory = category;
    setState(() {});
  }
}
