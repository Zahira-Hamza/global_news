import 'package:json_annotation/json_annotation.dart';

part 'sources.g.dart';

@JsonSerializable()
class Sources {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "url")
  final String? url;
  @JsonKey(name: "category")
  final String? category;
  @JsonKey(name: "language")
  final String? language;
  @JsonKey(name: "country")
  final String? country;

  Sources({
    this.id,
    this.name,
    this.description,
    this.url,
    this.category,
    this.language,
    this.country,
  });

  factory Sources.fromJson(Map<String, dynamic> json) {
    return _$SourcesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SourcesToJson(this);
  }
}
