import 'package:dio/dio.dart';
import 'package:the_movie_db/config/config.dart';

class Petition {
  get init {
    _addInterceptor();
    return _dio;
  }

  static final _dio = Dio(BaseOptions(baseUrl: Config.apiUrl,connectTimeout: const Duration(seconds: 5)));

  _addInterceptor() {
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
          String token = Config.apiToken;
          options.headers["Authorization"] = "Bearer $token";
          return handler.next(options);
        }));
  }
}

final Dio petition = Petition().init;

