import 'package:json_annotation/json_annotation.dart';

import 'News.dart';

part 'news_articles.g.dart';

@JsonSerializable()
class NewsArticles {
  @JsonKey(name: "source")
  final Source? source;
  @JsonKey(name: "author")
  final String? author;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "url")
  final String? url;
  @JsonKey(name: "urlToImage")
  final String? urlToImage;
  @JsonKey(name: "publishedAt")
  final String? publishedAt;
  @JsonKey(name: "content")
  final String? content;

  NewsArticles({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory NewsArticles.fromJson(Map<String, dynamic> json) {
    return _$NewsArticlesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$NewsArticlesToJson(this);
  }
}
