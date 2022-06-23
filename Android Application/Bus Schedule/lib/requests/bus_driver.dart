import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../helpers/dio_exceptions.dart';

String baseUrl = 'http://ec2-44-201-223-168.compute-1.amazonaws.com:4000/';

Dio _dio = Dio();

Future<String> getBusRoute(int busId) async {
  String url = '$baseUrl/getBusRouteByID?ID=$busId';
  try {
    _dio.options.contentType = Headers.jsonContentType;
    final responseData = await _dio.get(url);
    return responseData.data;
  } catch (e) {
    final errorMessage = DioExceptions.fromDioError(e as DioError).toString();
    debugPrint(errorMessage);
    return "";
  }
}
