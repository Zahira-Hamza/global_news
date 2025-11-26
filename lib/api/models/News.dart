import 'package:json_annotation/json_annotation.dart';

import 'news_articles.dart';

part 'News.g.dart';

@JsonSerializable()
class News {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "totalResults")
  final int? totalResults;
  @JsonKey(name: "articles")
  final List<NewsArticles>? articles;

  News({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return _$NewsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$NewsToJson(this);
  }
}

//! Sources is the same of the Source ,but with reacher fields so either of them can be used
@JsonSerializable()
class Source {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;

  Source({
    this.id,
    this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return _$SourceFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SourceToJson(this);
  }
}
