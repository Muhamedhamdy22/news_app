import 'package:flutter/material.dart';
import 'package:news_app/core/api_manager.dart';
import 'package:news_app/screens/widdget/article_item.dart';

class NewsData extends StatelessWidget {
   String sourceId;

   NewsData({required this.sourceId, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getNewsData(sourceId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("something Went Wrong"));
        }else {
          var data = snapshot.data;
          return ListView.builder(
            itemCount: data?.articles?.length?? 0,
            itemBuilder: (context, index) {
            return ArticleItem(article: data!.articles![index]);
          },);
        }
      },
    );
  }
}
