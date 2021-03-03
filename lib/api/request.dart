import 'package:dio/dio.dart';
import 'package:flutter_example_code/utils/cookie_manager.dart';

class Request {
  Dio dio;
  //change to your backend ip, remember localhost is unvalid
  final BaseOptions options = new BaseOptions(
    baseUrl: 'http://192.168.0.109:8080',
    connectTimeout: 15000,
    receiveTimeout: 13000,
  );

  static final Request _instance = Request._internal();

  factory Request() => _instance;

  Request._internal() {
    dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(Options options) async {
          // to prevent other request enter this interceptor.
          dio.interceptors.requestLock.lock();
          // We use a new Dio(to avoid dead lock) instance to request token.
          //Set the cookie to headers
          options.headers["cookie"] = await _generateCookieHeader();
          dio.interceptors.requestLock.unlock();
          return options; //continue
        }
    ));
  }


  Future<String> _generateCookieHeader() async{
    String cookie = '';
    final keys = CookieManager.getKeys();
    for (var key in keys) {
      if (cookie.length > 0)
        cookie += ";";
      cookie += key + "=" + CookieManager.getString(key);
    }
    return cookie;
  }
}

Request globalRequest = new Request();