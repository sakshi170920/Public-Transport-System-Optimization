import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:busoptimizer/helpers/shared_prefs.dart';

class BusListView extends StatefulWidget {
  static const String id = "BusListViewScreen";
  const BusListView({Key? key}) : super(key: key);

  @override
  State<BusListView> createState() => _BusListViewState();
}

class _BusListViewState extends State<BusListView> {
  late String source;
  late String destination;
  Map data = {};
  Future<String> getData() async {
    String url =
        "http://ec2-44-201-223-168.compute-1.amazonaws.com:4000/getAllCities";
    final response = await http.get(Uri.parse(url));

    this.setState(() {
      data = jsonDecode(response.body);
      // for (i,j) in temp;
      // print(temp);

      // print(temp['0']);
      // print(temp['0'][0]);
    });
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    source = getSourceAndDestination('source');
    destination = getSourceAndDestination('destination');
    this.getData();
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
        body: ListView.builder(
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
                                source.replaceAll(
                                    "\"", ""), // data['src_name']!,
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
                                destination.replaceAll(
                                    "\"", ""), // data['des_name']!,
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
                              // data['distance'].toString() +
                              // ' KM, via ' +
                              // data['inter_towns']!,
                              " 258KM ,via town",
                              maxLines: 2,
                              // overflow: TextOverflow.ellipsis,

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
                            // data['brand']! +
                            // ', ' +
                            // data['chair_count'].toString() +
                            // ' seater, ' +
                            // ['Non-AC', 'AC'][data['ac']!],
                            "JBCL, 50 seater, AC",
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
                            "start time",
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
                            // data['duration'].toString(),
                            "duration",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
