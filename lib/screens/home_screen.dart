import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/api_manager.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("News App")),
      body: FutureBuilder(
        future: ApiManager.getSources(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("something Went Wrong"));
          } else {
            var data = snapshot.data;
            return DefaultTabController(
              length: data?.sources?.length ?? 0,
              initialIndex: selectedIndex,
              child: TabBar(
                onTap: (value) {
                  selectedIndex = value;
                  setState(() {});
                },
                isScrollable: true,
                padding: EdgeInsets.zero,
                tabAlignment: TabAlignment.start,
                dividerColor: Colors.transparent,
                labelStyle: GoogleFonts.inter(
                  color: Color(0xFF171717),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: GoogleFonts.inter(
                  color: Color(0xFF171717),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                indicatorColor: Color(0xFF171717),
                unselectedLabelColor: Color(0xFF171717),
                labelColor: Color(0xFF171717),
                tabs:
                    data?.sources
                        ?.map((e) => Tab(child: Text(e.name ?? "")))
                        .toList() ??
                    [],
              ),
            );
          }
        },
      ),
    );
  }
}
