import 'dart:convert';

import 'package:flutter/material.dart';

import '../helpers/shared_prefs.dart';
import '../screens/turn_by_turn.dart';

Widget reviewRideBottomSheet(
    BuildContext context, String distance, String dropOffTime) {
  Map routeInfo =  jsonDecode(getDriverRouteFromSharedPrefs());
  String sourceAddress = routeInfo["1"][0];
  String destinationAddress = routeInfo[(routeInfo.length-1).toString()][0];

  return Card(
    clipBehavior: Clip.antiAlias,
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 1,
            child: Text('$sourceAddress ➡ $destinationAddress',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.indigo)),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: ListTile(
                tileColor: Colors.grey[200],
                leading: const Image(
                    image: AssetImage('assets/image/sport-car.png'),
                    height: 40,
                    width: 40),
                title: const Text('Premier',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text('$distance km, $dropOffTime drop off'),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, TurnByTurn.id),
                style:
                    ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Start your premier ride now'),
                    ])),
          ),
        ]),
  );
}
