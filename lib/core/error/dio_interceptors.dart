import 'package:dio/dio.dart';

import '../../core/error/app_exception.dart';

class DioInterceptors extends Interceptor {
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppException exception;
    final responseData = err.response?.data;
    String message = "Something went wrong";
//! 1- check if the response is json
    //* due to that the response is different like in password failed the response comes with the status code and the message directly,
    //*but in the email failed the response comes with object called error and this object has msg attrabiute inside it
    //?so we did check on that in the following if
    //!!! its not a standard scenario its due to the response of the api in the fail
    if (responseData is Map) {
      message = (responseData["errors"]?["msg"] as String?) ??
          (responseData["message"] as String?) ??
          message;
    }
    //!2- check on dio exception error type
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.connectionError) {
      exception = NetworkException(message: message);
    } else if (err.response?.statusCode != null) {
      exception = ServerException(
          message: message, statusCode: err.response?.statusCode);
    } else {
      exception = UnexpectedException(message: message);
    }

    handler.reject(
        DioException(requestOptions: err.requestOptions, error: exception));
  }
}
//!This means:
//* Instead of the original DioException, your API call will receive your custom AppException
// *You get standardized error handling across your entire app
// *The error will be one of: NetworkException, ServerException, or UnexpectedException
//! What handler.reject() does:
//* Stops further processing - No more interceptors in the chain will be executed
// *Returns the error to the original API call that triggered the request
// *Completes the Future with the error, so your try-catch block can handle it
// Your API call
// try {
// final response = await dio.get('/api/data');
// print('Success: $response');
// } catch (error) {
// This catches the error you passed to handler.reject()
// print('Error: $error'); // This will be your AppException
// }
