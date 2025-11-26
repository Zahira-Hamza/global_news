import 'package:news_app/api/models/News.dart';
import 'package:news_app/api/models/News_Sources.dart';

abstract class RemoteDataSource {
  Future<NewsSources> getNewsSources(String categoryId);
  Future<News> getNewsArticles(String sourceId, int page, int pageSize);
}
