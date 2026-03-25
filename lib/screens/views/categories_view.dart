import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/theme/bloc/cubit.dart';
import 'package:news_app/models/category_modal.dart';

class CategoriesView extends StatelessWidget {
  Function onCategoryClicked;
  CategoriesView({super.key , required this.onCategoryClicked});

  var categories = CategoryModal.getCategoriesList();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeCubit.get(context).baseTheme.background,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Morning\nHere is Some News For You",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF171717),
                ),
              ),
              SizedBox(height: 18),
              ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 18),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  bool isLeft = index % 2 == 0;
                  return GestureDetector(
                    onTap: () {
                      onCategoryClicked(categories[index]);
                    },
                    child: Stack(
                      alignment: index.isOdd
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight,
                      children: [
                        Align(
                          alignment: isLeft
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(18),
                            child: Image.asset(
                              categories[index].image,
                              width: 150,
                              height: 150,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: index.isOdd ? 0 : 12,
                            right: index.isEven ? 0 : 12,
                          ),
                          margin: EdgeInsets.only(
                            bottom: 24,
                            left: index.isOdd ? 0 : 12,
                            right: index.isEven ? 0 : 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.5),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Visibility(
                                visible: index.isOdd,
                                child: Image.asset("assets/images/arrow_back.png"),
                              ),
                              Text(
                                "View All",
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF171717),
                                ),
                              ),
                              Visibility(
                                visible: index.isEven,
                                child: Image.asset("assets/images/arrow.png"),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 120,
                          left: index.isEven ? null : 35,
                          right: index.isEven ? 35 : null,
                          child: Text(
                            categories[index].label,
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF171717),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: categories.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
