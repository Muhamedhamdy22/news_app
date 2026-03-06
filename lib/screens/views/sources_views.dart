import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:news_app/core/internet_checker.dart';
import 'package:news_app/repository/home_local_repo.dart';
import 'package:news_app/repository/home_remote_repo.dart';
import 'package:news_app/screens/cubit/cubit.dart';
import 'package:news_app/screens/cubit/states.dart';
import 'package:news_app/screens/news_data.dart';

class SourcesViews extends StatelessWidget {
  String ctId;
   SourcesViews({super.key, required this.ctId});
bool isConnected = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        InternetConnectivity().isConnected ? HomeRemoteRepo() : HomeLocalRepo()
      )..getSources(ctId),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is GetSourcesLoadingState) {
            context.loaderOverlay.show();
          }else {
            context.loaderOverlay.hide();
          }
        },
        builder: (context, state) {
          // var cubit = BlocProvider.of<HomeCubit>(context);
          return Column(
            children: [
              DefaultTabController(
                length: HomeCubit.get(context).sources.length,
                initialIndex: HomeCubit.get(context).selectedIndex,
                child: TabBar(
                  onTap: (value) {
                    HomeCubit.get(context).onTapChanged(value);
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
                  tabs: HomeCubit.get(context).sources
                      .map((e) => Tab(child: Text(e.name ?? "")))
                      .toList(),
                ),
              ),
              Expanded(child: NewsData()),
            ],
          );
        },
      ),
    );
  }
}

