
import 'package:dio/dio.dart';
import '../Constants.dart';

import 'package:logger/logger.dart';

class ApiService {
  static ApiService instanse;

  Dio _dio;

  ApiService() {
    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 90000,
      receiveTimeout: 90000,
      sendTimeout: 90000,
    );

    _dio = new Dio(options);

/*    final token = Preference.getString(Constants.TOKEN);
    // Logger.print(token);
    if (token != null) {
      addAuthInterceptor(token);
    } else {
      addErrorHandler();
    }*/
  }

  static ApiService getInstance() {
    if (instanse == null) {
      instanse = ApiService();
    }

    return instanse;
  }

  Dio getClient() {
    return _dio;
  }

  void addErrorHandler() {
    var _errorHandler;
    _dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (Response response) async {
/*          AppLogger.print(response.toString());*/
          return response;
        },
        onError: _errorHandler,
      ),
    );
  }

  void addAuthInterceptor(String token) {
    if (_dio.interceptors.length > 0) {
      _dio.interceptors.removeAt(0);
    }

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          options.headers["Authorization"] = token;
          return options;
        },
        onResponse: (Response response) async {
          return response;
        },
        onError: errorHandler,
      ),
    );
  }

  Future<String> errorHandler(DioError dioError) async {
/*    AppLogger.print(dioError.toString());*/

    String message;
    if (dioError.type == DioErrorType.RESPONSE) {
      final data = dioError.response.data;
  /*    AppLogger.print(data.toString());*/

      if (dioError.response.statusCode == 400) {
        message = data['error'];
      } else if (dioError.response.statusCode == 401) {
        message = data['error'];
        if (!message.toLowerCase().contains("otp")){
          /*   ExtendedNavigator.root.replace(Routes.loginScreen);*/
        }

      } else if (dioError.response.statusCode == 403) {
        message = "Forbidden";
      } else if (dioError.response.statusCode == 404) {
        message = "Not found";
      } else if (dioError.response.statusCode == 405) {
        message = "Route does not exist";
      } else if (dioError.response.statusCode == 500) {
        message = dioError.message;
      } else {
        message = "Something went wrong";
      }
    } else if (dioError.type == DioErrorType.CONNECT_TIMEOUT) {
      message = "connection timedout";
    } else if (dioError.type == DioErrorType.DEFAULT) {
      if (dioError.message.contains('SocketException')) {
        message = "Internet not Available";
      }
    }



    return message;
  }
}