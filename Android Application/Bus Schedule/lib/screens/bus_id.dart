import 'package:busoptimizer/helpers/mapbox_handler.dart';
import 'package:busoptimizer/main.dart';
import 'package:busoptimizer/screens/review_ride.dart';
import 'package:flutter/material.dart';

import '../helpers/constants.dart';
import '../requests/mapbox_driver.dart';

class BusId extends StatefulWidget {
  static const String id = "BusIdScreen";
  const BusId({Key? key}) : super(key: key);

  @override
  State<BusId> createState() => _BusIdState();
}

class _BusIdState extends State<BusId> {
  late int busId;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Image.asset(
              'assets/image/logo.png',
              width: 200,
              height: 200,
            ),
          ),
          SizedBox(
            width: 300.0,
            height: 42.0,
            child: TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                busId = int.parse(value);
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Bus Id'),
            ),
          ),
          Container(
            color: Colors.lightBlueAccent,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(10),
            child: MaterialButton(
              minWidth: 290.0,
              height: 42.0,
              onPressed: () async {
                if (busId != null) {
                  String routeInfo = await getBusRoute(busId);
                  sharedPreferences.setString("driverRoute", routeInfo);
                  Map modifiedResponse = await getDirectionsAPIResponse();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              ReviewRide(modifiedResponse: modifiedResponse)));
                }
              },
              child: Text(
                'Show Route',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
