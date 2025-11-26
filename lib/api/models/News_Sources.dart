import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/api/models/sources.dart';

part 'News_Sources.g.dart';

@JsonSerializable()
class NewsSources {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "sources")
  final List<Sources>? sources;

  NewsSources({
    this.status,
    this.sources,
  });

  factory NewsSources.fromJson(Map<String, dynamic> json) {
    return _$NewsSourcesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$NewsSourcesToJson(this);
  }
}


