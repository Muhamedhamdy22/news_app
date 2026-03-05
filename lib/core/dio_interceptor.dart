import 'package:dio/dio.dart';
import 'package:news_app/core/constants.dart' as AppConsdtants;

class MyInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["x-api-key"] = AppConsdtants.APIKEY;
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}