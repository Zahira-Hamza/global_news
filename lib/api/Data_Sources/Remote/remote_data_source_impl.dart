import 'package:injectable/injectable.dart';
import 'package:news_app/api/Data_Sources/Remote/remote_data_source.dart';
import 'package:news_app/api/models/News.dart';
import 'package:news_app/api/models/News_Sources.dart';
import 'package:news_app/api/web_services.dart';
import 'package:news_app/core/error/app_exception.dart'; // Adjust path as needed

@Injectable(as: RemoteDataSource)
class RemoteDataSourceImpl implements RemoteDataSource {
  final WebServices webServices;

  RemoteDataSourceImpl(this.webServices);

  @override
  Future<NewsSources> getNewsSources(String categoryId) async {
    try {
      return await webServices.getNewsSources(categoryId);
    } on AppException {
      // Let AppException bubble up (handled by interceptor)
      rethrow;
    } catch (e) {
      // For any non-AppException errors (rare, but possible)
      throw UnexpectedException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<News> getNewsArticles(String sourceId, int page, int pageSize) async {
    try {
      return await webServices.getNewsArticles(sourceId, page, pageSize);
    } on AppException {
      // Let AppException bubble up (handled by interceptor)
      rethrow;
    } catch (e) {
      // For any non-AppException errors (rare, but possible)
      throw UnexpectedException(message: 'Unexpected error: ${e.toString()}');
    }
  }
}
