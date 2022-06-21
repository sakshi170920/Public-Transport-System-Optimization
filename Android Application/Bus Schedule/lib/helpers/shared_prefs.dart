import 'package:mapbox_gl/mapbox_gl.dart';

import '../main.dart';

LatLng getCurrentLatLngFromSharedPrefs() {
  return LatLng(sharedPreferences.getDouble('latitude')!,
      sharedPreferences.getDouble('longitude')!);
}

String getCurrentAddressFromSharedPrefs() {
  return sharedPreferences.getString('current-address')!;
}

String getDriverRouteFromSharedPrefs() {
  return sharedPreferences.getString('driverRoute')!;
}

String getSourceAndDestination(String type) {
  String sourceAddress =
      sharedPreferences.getString('source')!;
  String destinationAddress =
      sharedPreferences.getString('destination')!;

  if (type == 'source') {
    return sourceAddress;
  } else {
    return destinationAddress;
  }
}
