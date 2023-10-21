

import 'package:dio/dio.dart';
import 'package:the_movie_db/config/config.dart';

class Petition {
  get init {
    _addInterceptor();
    return _dio;
  }

  static final _dio = Dio(BaseOptions(baseUrl: Config.apiUrl));

  String _token='';

  _addInterceptor() {
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
          String token = Config.apiToken;
          if (token.isNotEmpty){
            _token = token;
          }
          options.headers["Authorization"] = "Bearer $_token";
          return handler.next(options);
        }));

  }
}


final Dio petition = Petition().init;

