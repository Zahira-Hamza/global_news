//! Exception handles the errors from the server or network side or unknown
//* convert dio error(interceptor) to app exception in dio_interceptors.dart
sealed class AppException implements Exception {
  String message;
  int? statusCode;
  AppException({required this.message, this.statusCode});
}

class ServerException extends AppException {
  ServerException({required super.message, super.statusCode});
}

class NetworkException extends AppException {
  NetworkException({required super.message, super.statusCode});
}

class UnexpectedException extends AppException {
  UnexpectedException({required super.message, super.statusCode});
}
