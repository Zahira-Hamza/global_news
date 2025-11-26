import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/core/error/app_exception.dart';

import '../../../../domain/Repositories_interface/news_repository.dart';
import 'news_event.dart';
import 'news_state.dart'; // Adjust path as needed

@injectable
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc(this.newsRepository) : super(NewsState.initial()) {
    on<GetNewsEvent>(_onGetNews);
    on<LoadMoreNewsEvent>(_onLoadMoreNews);
    on<ResetNewsEvent>(_onResetNews);
  }

  Future<void> _onGetNews(GetNewsEvent event, Emitter<NewsState> emit) async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final response = await newsRepository.getNewsArticles(
          event.sourceId, event.page, event.pageSize);

      if (response.status != 'ok') {
        throw ServerException(
            message: response.articles?.isNotEmpty == true
                ? 'Error fetching news'
                : 'No news available');
      }

      final fetched = response.articles ?? [];
      emit(state.copyWith(
        articles: event.page == 1 ? fetched : [...state.articles, ...fetched],
        page: event.page,
        hasMore: fetched.length >= event.pageSize,
        isLoading: false,
        error: null,
      ));
    } on AppException catch (e) {
      // Handle based on exception type
      String errorMessage;
      if (e is NetworkException) {
        errorMessage = 'Network error: ${e.message}';
      } else if (e is ServerException) {
        errorMessage = 'Server error (${e.statusCode}): ${e.message}';
      } else {
        errorMessage = e.message;
      }
      emit(state.copyWith(isLoading: false, error: errorMessage));
    } catch (e) {
      // Fallback
      emit(state.copyWith(
          isLoading: false, error: 'Unexpected error: ${e.toString()}'));
    }
  }

  Future<void> _onLoadMoreNews(
      LoadMoreNewsEvent event, Emitter<NewsState> emit) async {
    if (state.isLoading || !state.hasMore) return;

    add(GetNewsEvent(event.sourceId,
        page: state.page + 1, pageSize: event.pageSize));
  }

  Future<void> _onResetNews(
      ResetNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsState.initial());
    add(GetNewsEvent(event.sourceId, page: 1));
  }
}
