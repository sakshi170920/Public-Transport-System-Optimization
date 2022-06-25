import 'dart:io';

import 'package:busoptimizer/helpers/mapbox_handler.dart';
import 'package:busoptimizer/main.dart';
import 'package:busoptimizer/requests/mapbox_directions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:busoptimizer/helpers/shared_prefs.dart';

import '../helpers/commons.dart';

class BusListView extends StatefulWidget {
  static const String id = "BusListViewScreen";
  Map routeDetails;
  BusListView({Key? key, required this.routeDetails}) : super(key: key);

  @override
  State<BusListView> createState() => _BusListViewState();
}

class _BusListViewState extends State<BusListView> {
  bool isValidInput = true;
  int sourceInd = 0;
  int destinationInd = 0;
  double srcLan = 0, srcLong = 0, destLan = 0, destLong = 0;
  Map data = {};
  Map indexingOfData = {};
  Future<String> getData() async {
    String url =
        "http://ec2-44-201-223-168.compute-1.amazonaws.com:4000/getBusesBySrcDest?src=" +
            widget.routeDetails["source"].replaceAll("\"", "").toLowerCase() +
            "&dest=" +
            widget.routeDetails["destination"]
                .replaceAll("\"", "")
                .toLowerCase();
    final response = await http.get(Uri.parse(url));

    this.setState(() {
      print(url);
      try {
        data = jsonDecode(response.body);
      } catch (error) {
        String apiData = response.body;
        if (apiData == "Invalid") {
          isValidInput = false;
        }
      }
      print(data);

      int ind = 0;
      for (var i in data.keys) {
        indexingOfData[ind] = i;
        ind++;
      }
      for (var i in data.keys) {
        for (int j = 0; j < data[i].length; j++) {
          // print(data[i][j]);
          if (data[i][j] is String) {
            continue;
          }

          if (data[i][j][0] == widget.routeDetails["source"].toString()) {
            sourceInd = j;
            srcLan = data[i][j][1][0];
            srcLong = data[i][j][1][1];
            break;
          }
        }

        for (int j = 0; j < data[i].length; j++) {
          if (data[i][j] is String) {
            continue;
          }
          if (data[i][j][0] == widget.routeDetails["destination"]) {
            destinationInd = j;
            destLan = data[i][j][1][0];
            destLong = data[i][j][1][1];
            break;
          }
        }
      }
    });
    return "Success!";
  }

  // _initialiseDirectionsResponse(Map modifiedResponse) {
  //   distance = (modifiedResponse['distance'] / 1000).toStringAsFixed(1);
  //   dropOffTime = getDropOffTime(widget.modifiedResponse['duration']);
  //   geometry = widget.modifiedResponse['geometry'];
  // }

  @override
  void initState() {
    super.initState();

    /// this need to removed
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mapbox Cabs'),
          actions: const [
            CircleAvatar(
                backgroundImage: AssetImage('assets/image/person.jpg')),
          ],
        ),
        body: isValidInput
            ? ListView.builder(
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (BuildContext cxt, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.blue[700],
                          borderRadius: BorderRadius.circular(12)),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'SOURCE',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  Text(
                                    widget.routeDetails["source"]
                                        .replaceAll("\"", "")
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const Text(
                                '→',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'DESTINATION',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  Text(
                                    widget.routeDetails["destination"]
                                        .replaceAll("\"", "")
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.directions,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  " Via " +
                                      data[indexingOfData[index]]
                                              [destinationInd - 1]
                                          [0], // hear need to add kilometer
                                  maxLines: 2,

                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.directions_bus,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "MSRTC, 50 seater, AC",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time_rounded,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                // data['start_time'].toString(),
                                data[indexingOfData[index]][0],
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              const Icon(
                                Icons.timelapse_rounded,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                // widget.routeDetails["duration"],
                                "duration",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                })
            : Center(
                child: Text("Oops sorry we dont have route for this cities"),
              ));
  }
}
