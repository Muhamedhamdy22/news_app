import 'package:hive/hive.dart';

import 'news_response.dart';

class NewsResponseAdapter extends TypeAdapter<NewsResponse> {
  @override
  final int typeId = 2;

  @override
  NewsResponse read(BinaryReader reader) {
    return NewsResponse(
      status: reader.read(),
      totalResults: reader.read(),
      articles: (reader.read() as List?)?.cast<Articles>(),
    );
  }

  @override
  void write(BinaryWriter writer, NewsResponse obj) {
    writer.write(obj.status);
    writer.write(obj.totalResults);
    writer.write(obj.articles);
  }
}

class ArticlesAdapter extends TypeAdapter<Articles> {
  @override
  final int typeId = 3;
  @override
  Articles read(BinaryReader reader) {
    return Articles(
      source: reader.read(),
      author: reader.read(),
      title: reader.read(),
      description: reader.read(),
      url: reader.read(),
      urlToImage: reader.read(),
      publishedAt: reader.read(),
      content: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Articles obj) {
    writer.write(obj.source);
    writer.write(obj.author);
    writer.write(obj.title);
    writer.write(obj.description);
    writer.write(obj.url);
    writer.write(obj.urlToImage);
    writer.write(obj.publishedAt);
    writer.write(obj.content);
  }
}