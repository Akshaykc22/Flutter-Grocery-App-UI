import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery_app/data/remote/routes.dart';

import 'custom_exception.dart';

class ApiProvider {
  late Dio dio;

  ApiProvider() {
    dio = Dio(
      BaseOptions(
        validateStatus: (status) {
          return true;
        },
        followRedirects: false,
        baseUrl: AppRemoteRoutes.baseUrl,
        connectTimeout: 30000,
        receiveTimeout: 30000,
      ),
    );
  }

  Future<Map<String, dynamic>> get(String endPoint) async {
    try {
      GetStorage sr = GetStorage();
      String? token = sr.read('token');
      print(token);
      dio.options.headers.addAll({'Authorization': 'Token $token'});
      final Response response = await dio.get(
        endPoint,
      );
      print(dio.options.headers);
      print(dio.options.baseUrl + endPoint);

      final Map<String, dynamic> responseData = classifyResponse(response);
      return responseData;
    } on DioError catch (err) {
      throw FetchDataException("internetError");
    }
  }

  Future<Map<String, dynamic>> post(
      String endPoint, Map<String, dynamic> body) async {
    print("on post call$body");
    try {
      print("starting dio");
      GetStorage sr = GetStorage();
      String? token = sr.read('token');
      print(token);
      dio.options.headers.addAll({'Authorization': 'Token $token'});
      final Response response = await dio.post(
        endPoint,
        data: body,
      );

      print("getting response${response}");
      final Map<String, dynamic> responseData = classifyResponse(response);
      print(responseData);
      return responseData;
    } on DioError catch (err) {
      print(err);
      throw FetchDataException("internetError");
    }
  }

  Future<Map<String, dynamic>> put(
      String endPoint, Map<String, dynamic> body) async {
    print("on post call");
    try {
      GetStorage sr = GetStorage();
      String? token = sr.read('token');
      print(token);
      dio.options.headers.addAll({'Authorization': 'Token $token'});
      print("starting dio");
      final Response response = await dio.put(
        endPoint,
        data: body,
      );
      print("getting response${response}");
      final Map<String, dynamic> responseData = classifyResponse(response);
      print(responseData);
      return responseData;
    } on DioError catch (err) {
      print(err);
      throw FetchDataException("internetError");
    }
  }

  Map<String, dynamic> classifyResponse(Response response) {
    print(response);
    final Map<String, dynamic> responseData =
        response.data as Map<String, dynamic>;
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
      case 201:
        return responseData;
      case 400:
        throw BadRequestException(responseData.toString());
      case 401:
        throw UnauthorisedException(responseData.toString());
      case 500:
      default:
        throw FetchDataException(
          'Error occurred while Communication with Server with StatusCode : ${response.statusCode}',
        );
    }
  }
}
