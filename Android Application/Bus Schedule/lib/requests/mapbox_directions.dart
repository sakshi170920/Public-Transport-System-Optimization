import 'dart:collection';
import 'dart:convert';

import 'package:busoptimizer/helpers/shared_prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../helpers/dio_exceptions.dart';

String baseUrl = 'https://api.mapbox.com/directions/v5/mapbox';
String accessToken = dotenv.env['MAPBOX_ACCESS_TOKEN']!;
String navType = 'driving';

Dio _dio = Dio();

Future getDriverRouteUsingMapbox() async {
  String driverRoute = getDriverRouteFromSharedPrefs();
  LinkedHashMap result = jsonDecode(driverRoute);
  String coordinates = "";

  result.forEach((key, value) {
    if (key != "-1") {
      LatLng temp = LatLng(value[1][0], value[1][1]);
      coordinates += temp.longitude.toString() + "," + temp.latitude.toString();
      if (key != result.keys.last) {
        coordinates += ';';
      }
    }
  });

  String url =
      '$baseUrl/$navType/$coordinates?alternatives=true&continue_straight=true&geometries=geojson&language=en&overview=full&steps=true&access_token=$accessToken';
  try {
    _dio.options.contentType = Headers.jsonContentType;
    final responseData = await _dio.get(url);
    return responseData.data;
  } catch (e) {
    final errorMessage = DioExceptions.fromDioError(e as DioError).toString();
    debugPrint(errorMessage);
  }
}
