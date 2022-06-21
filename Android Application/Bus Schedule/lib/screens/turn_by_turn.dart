import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import '../helpers/shared_prefs.dart';
import '../screens/home.dart';

class TurnByTurn extends StatefulWidget {
  static const String id = "TurnByTurnScreen";
  const TurnByTurn({Key? key}) : super(key: key);

  @override
  State<TurnByTurn> createState() => _TurnByTurnState();
}

class _TurnByTurnState extends State<TurnByTurn> {

  var wayPoints = <WayPoint>[];

  // Config variables for Mapbox Navigation
  late MapBoxNavigation directions;
  late MapBoxOptions _options;
  late double distanceRemaining, durationRemaining;
  final bool isMultipleStop = false;
  String instruction = "";
  bool arrived = false;
  bool routeBuilt = false;
  bool isNavigating = false;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    if (!mounted) return;

    // Setup directions and options
    directions = MapBoxNavigation(onRouteEvent: _onRouteEvent);
    _options = MapBoxOptions(
        zoom: 18.0,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        mode: MapBoxNavigationMode.drivingWithTraffic,
        isOptimized: true,
        units: VoiceUnits.metric,
        simulateRoute: true,
        language: "en");

    // Configure waypoints
    Map routeInfo = jsonDecode(getDriverRouteFromSharedPrefs());

    routeInfo.forEach((key, value) {
      wayPoints
        .add(WayPoint(name: value[0], latitude: value[1][0], longitude: value[1][1]));
     });

    // Start the trip
    await directions.startNavigation(wayPoints: wayPoints, options: _options);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }

  Future<void> _onRouteEvent(e) async {
    try {
      durationRemaining = await directions.durationRemaining;
    } catch (e) {
      durationRemaining = 0;
    }

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        arrived = progressEvent.arrived!;
        if (progressEvent.currentStepInstruction != null) {
          instruction = progressEvent.currentStepInstruction!;
        }
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        routeBuilt = true;
        break;
      case MapBoxEvent.route_build_failed:
        routeBuilt = false;
        break;
      case MapBoxEvent.navigation_running:
        isNavigating = true;
        break;
      case MapBoxEvent.on_arrival:
        arrived = true;
        if (!isMultipleStop) {
          await Future.delayed(const Duration(seconds: 3));
          Navigator.popUntil(context, ModalRoute.withName(Home.id));
          //await _controller.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
        routeBuilt = false;
        isNavigating = false;
        //TODO DO SMOETHING
        Navigator.popUntil(context, ModalRoute.withName(Home.id));
        break;

      case MapBoxEvent.navigation_cancelled:
        routeBuilt = false;
        isNavigating = false;
        Navigator.popUntil(context, ModalRoute.withName(Home.id));
        break;
      default:
        break;
    }
    //refresh UI
    setState(() {});
  }
}
