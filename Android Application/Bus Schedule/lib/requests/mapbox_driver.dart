import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

Future<List> getAllCities() async {
  String url = '$baseUrl/getAllCities';
  List cities = [];
  try {
    _dio.options.contentType = Headers.jsonContentType;
    final responseData = await _dio.get(url);
    Map response = jsonDecode(responseData.data);
    response.forEach((key, value) {
      cities.add(
          {"name": value[0], "location": LatLng(value[1][0], value[1][1])});
    });
  } catch (e) {
    final errorMessage = DioExceptions.fromDioError(e as DioError).toString();
    debugPrint(errorMessage);
  }
  return cities;
}
