import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/core/error/app_exception.dart'; // Adjust path as needed

import '../../../../domain/Repositories_interface/news_repository.dart';
import 'category_sources_event.dart';
import 'category_sources_state.dart';

@injectable
class CategorySourcesBloc
    extends Bloc<CategorySourcesEvent, CategorySourcesState> {
  final NewsRepository newsRepository;

  CategorySourcesBloc(this.newsRepository) : super(CategorySourcesInitial()) {
    on<GetSourcesEvent>(_onGetSources);
  }

  Future<void> _onGetSources(
      GetSourcesEvent event, Emitter<CategorySourcesState> emit) async {
    try {
      emit(CategorySourcesLoading());
      final response = await newsRepository.getNewsSources(event.categoryId);
      if (response.status == 'error') {
        emit(CategorySourcesError(response.sources?.isNotEmpty == true
            ? 'Error fetching sources'
            : 'No sources available'));
      } else {
        emit(CategorySourcesSuccess(response.sources ?? []));
      }
    } on AppException catch (e) {
      // Handle based on exception type for better UX (e.g., different messages)
      String errorMessage;
      if (e is NetworkException) {
        errorMessage = 'Network error: ${e.message}';
      } else if (e is ServerException) {
        errorMessage = 'Server error (${e.statusCode}): ${e.message}';
      } else {
        errorMessage = e.message; // UnexpectedException or generic
      }
      emit(CategorySourcesError(errorMessage));
    } catch (e) {
      // Fallback for any other unexpected errors
      emit(CategorySourcesError('Unexpected error: ${e.toString()}'));
    }
  }
}
