import 'package:equatable/equatable.dart';
import 'package:news_app/api/models/news_articles.dart'; // Assuming Articles maps to NewsArticles

class NewsState extends Equatable {
  final List<NewsArticles> articles;
  final int page;
  final bool isLoading;
  final bool hasMore;
  final String? error;

  const NewsState({
    required this.articles,
    required this.page,
    required this.isLoading,
    required this.hasMore,
    this.error,
  });

  factory NewsState.initial() {
    return const NewsState(
      articles: [],
      page: 1,
      isLoading: false,
      hasMore: true,
      error: null,
    );
  }

  NewsState copyWith({
    List<NewsArticles>? articles,
    int? page,
    bool? isLoading,
    bool? hasMore,
    String? error,
  }) {
    return NewsState(
      articles: articles ?? this.articles,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [articles, page, isLoading, hasMore, error];
}
