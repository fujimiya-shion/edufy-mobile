import 'package:dio/dio.dart';
import 'package:edufy_mobile/src/core/dependencies/ioc.dart';
import 'package:edufy_mobile/src/data/repositories/local/pref_repository.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final prefs = locator<PrefRepository>();

    final userToken = prefs.userToken;
    if (userToken.isNotEmpty) {
      options.headers['User-Authorization'] = 'Bearer $userToken';
    }

    super.onRequest(options, handler);
  }
}
