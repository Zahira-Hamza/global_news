import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/api/api_endpoints.dart'; // Adjust import to your news app's path
import 'package:news_app/api/web_services.dart'; // Adjust import
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class DioModule {
  // Provides BaseOptions with global config, including apiKey as a query param.
  // This centralizes settings and allows removing baseUrl from WebServices.
  @singleton
  @injectable
  BaseOptions provideBaseOptions() {
    // TODO: Store apiKey securely (e.g., via flutter_dotenv or secure storage). Never hardcode in production!
    const String apiKey =
        '296f72395270463e824806f6b5d5b99f'; // Replace with your key or load from env

    return BaseOptions(
      baseUrl: ApiEndpoints.baseUrl, // Global base URL for all requests
      queryParameters: {
        'apiKey':
            apiKey, // Adds apiKey to EVERY request automatically (as a query param)
      },
      receiveDataWhenStatusError:
          true, // Allow responses even on errors (e.g., 4xx/5xx)
      connectTimeout: const Duration(seconds: 20), // Timeout for connection
      receiveTimeout: const Duration(seconds: 20), // Timeout for receiving data
    );
  }

  // Provides PrettyDioLogger for logging requests/responses/errors.
  // This replaces Dio's LogInterceptor and gives prettier output.
  @singleton
  @injectable
  PrettyDioLogger provideLogger() {
    return PrettyDioLogger(
      requestHeader: true, // Log request headers
      requestBody: true, // Log request body
      responseBody: true, // Log response body
      responseHeader: false, // Skip response headers for cleaner logs
      error: true, // Log errors
      compact: true, // Compact log format
    );
  }

  // Provides Dio instance, injecting BaseOptions and logger.
  // Add more interceptors here if needed (e.g., for auth or retries).
  @singleton
  @injectable
  Dio provideDio(BaseOptions baseOptions, PrettyDioLogger prettyLogger) {
    final dio = Dio(baseOptions);
    dio.interceptors.add(prettyLogger); // Add logger
    // TODO: Add more interceptors, e.g.:
    // dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) { /* auth logic */ }));
    return dio;
  }

  // Provides WebServices (your Retrofit class), injecting Dio.
  @singleton
  @injectable
  WebServices provideWebServices(Dio dio) => WebServices(dio);
}
