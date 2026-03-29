import 'package:hive/hive.dart';
import 'package:news_app/models/sources_responce.dart';

class SourcesResponseAdapter extends TypeAdapter<SourcesResponse> {
  @override
  final int typeId = 0;

  @override
  SourcesResponse read(BinaryReader reader) {
    return SourcesResponse(
      status: reader.read(),
      sources: (reader.read() as List).cast<Sources>(),
    );
  }

  @override
  void write(BinaryWriter writer, SourcesResponse obj) {
    writer.write(obj.status);
    writer.write(obj.sources);
  }
}



class SourcesAdapter extends TypeAdapter<Sources> {
  @override
  final int typeId = 1;

  @override
  Sources read(BinaryReader reader) {
    return Sources(
      id: reader.read(),
      name: reader.read(),
      description: reader.read(),
      url: reader.read(),
      category: reader.read(),
      language: reader.read(),
      country: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Sources obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.description);
    writer.write(obj.url);
    writer.write(obj.category);
    writer.write(obj.language);
    writer.write(obj.country);
  }
}