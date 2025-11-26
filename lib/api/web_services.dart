import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'api_endPoints.dart';
import 'models/News.dart';
import 'models/News_Sources.dart';

part 'web_services.g.dart';

@RestApi()
abstract class WebServices {
  factory WebServices(Dio dio, {String? baseUrl}) = _WebServices;
//! the return type of the api methode its the response not the inner classes i did separated + data sources ,but not the repo and the view model

  @GET(ApiEndpoints.sourcesApi)
  Future<NewsSources> getNewsSources(String categoryId);

  @GET(ApiEndpoints.newsApi)
  Future<News> getNewsArticles(
    @Query("sources") String sourceId,
    @Query("page") int page,
    @Query("pageSize") int pageSize,
  );
}
//! BaseOptions(common between the api methods) + logger }-> dio_module
//!web_services already injected using the dio_module
