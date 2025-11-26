import 'package:injectable/injectable.dart';
import 'package:news_app/api/models/News.dart';
import 'package:news_app/api/models/News_Sources.dart';
import 'package:news_app/core/error/app_exception.dart';

import '../../api/Data_Sources/Remote/remote_data_source.dart';
import '../../domain/Repositories_interface/news_repository.dart'; // Adjust path as needed

@Injectable(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  final RemoteDataSource remoteDataSource;

  NewsRepositoryImpl(this.remoteDataSource);

  @override
  Future<NewsSources> getNewsSources(String categoryId) async {
    try {
      return await remoteDataSource.getNewsSources(categoryId);
    } on AppException {
      // Let AppException bubble up
      rethrow;
    } catch (e) {
      // For any non-AppException errors (rare, but possible)
      throw UnexpectedException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<News> getNewsArticles(String sourceId, int page, int pageSize) async {
    try {
      return await remoteDataSource.getNewsArticles(sourceId, page, pageSize);
    } on AppException {
      // Let AppException bubble up
      rethrow;
    } catch (e) {
      // For any non-AppException errors (rare, but possible)
      throw UnexpectedException(message: 'Unexpected error: ${e.toString()}');
    }
  }
}
