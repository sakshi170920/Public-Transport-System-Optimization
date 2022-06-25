import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:busoptimizer/screens/bus_list.dart';
import 'package:busoptimizer/widgets/passenger_search_listview.dart';
import '../helpers/mapbox_handler.dart';
import '../helpers/shared_prefs.dart';
import '../main.dart';
import '../widgets/endpoints_card.dart';

class PrepareRide extends StatefulWidget {
  static const String id = "PrepareRideScreen";
  const PrepareRide({Key? key}) : super(key: key);

  @override
  State<PrepareRide> createState() => _PrepareRideState();

  // Declare a static function to reference setters from children
  static _PrepareRideState? of(BuildContext context) =>
      context.findAncestorStateOfType<_PrepareRideState>();
}

class _PrepareRideState extends State<PrepareRide> {
  bool isLoading = false;
  bool isEmptyResponse = true;
  bool hasResponded = false;
  bool isResponseForDestination = false;

  String noRequest = 'Please enter an address, a place or a location to search';
  String noResponse = 'No results found for the search';

  List responses = [];
  TextEditingController sourceController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  var sourceInfo;

  // Define setters to be used by children widgets
  set responsesState(List responses) {
    setState(() {
      this.responses = responses;
      hasResponded = true;
      isEmptyResponse = responses.isEmpty;
    });
    Future.delayed(
      const Duration(milliseconds: 500),
      () => setState(() {
        isLoading = false;
      }),
    );
  }

  set isLoadingState(bool isLoading) {
    setState(() {
      this.isLoading = isLoading;
    });
  }

  set isResponseForDestinationState(bool isResponseForDestination) {
    setState(() {
      this.isResponseForDestination = isResponseForDestination;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          CircleAvatar(backgroundImage: AssetImage('assets/image/person.jpg')),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              endpointsCard(sourceController, destinationController),
              isLoading
                  ? const LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                  : Container(),
              isEmptyResponse
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                          child: Text(hasResponded ? noResponse : noRequest)))
                  : Container(),
              passengerSearchListView(responses, isResponseForDestination,
                  destinationController, sourceController)
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () async {
            Map sourceInfo = jsonDecode(getSourceAndDestination('source-info'));
            Map destinationInfo =
                jsonDecode(getSourceAndDestination('destination-info'));
            String source = sourceInfo["name"];
            String destination = destinationInfo["name"];
            List src = sourceInfo["location"];
            List dest = destinationInfo["location"];
            String routeInfo =
                "{\"0\":[\"$source\",$src],\"1\":[\"$destination\",$dest]}";
            sharedPreferences.setString("driverRoute", routeInfo);
            Map result = await getDirectionsAPIResponse();
            var distance = (result['distance'] / 1000).toStringAsFixed(1);
            var min = (result['duration'] / 60).round();
            var sec = (result['duration'] % 60).round();
            Map routeDetails = {
              "distance": distance,
              "duration": "$min min: $sec s",
              "source": source,
              "destination": destination,
            };
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BusListView(routeDetails: routeDetails)));
          },
          child: const Text("Show Buses")),
    );
  }
}
