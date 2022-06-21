import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:busoptimizer/helpers/user_mode.dart';
import 'package:busoptimizer/screens/prepare_ride.dart';

bool _searchBoolean = false;
List<int> _searchIndexList = [];

List<String> _list = [
  'English Textbook',
  'Japanese Textbook',
  'English Vocabulary',
  'Japanese Vocabulary'
];

Completer<GoogleMapController> _controller = Completer();
const LatLng _center = LatLng(45.521563, -122.677433);
void _onMapCreated(GoogleMapController controller) {
  if (!_controller.isCompleted) _controller.complete(controller);
}

class HomePage extends StatefulWidget {
  static const String id = "HomePage";
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  Widget _searchTextField() {
    return TextField(
      onChanged: (String s) {
        setState(() {
          _searchIndexList = [];
          for (int i = 0; i < _list.length; i++) {
            if (_list[i].contains(s)) {
              _searchIndexList.add(i);
            }
          }
        });
      },
      autofocus: true,
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }


  void navigateToPrepareRide(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                const PrepareRide(userMode: UserMode.passengerMode)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: !_searchBoolean ? Text(widget.title) : _searchTextField(),
        //   actions: !_searchBoolean
        //       ? [
        //           IconButton(
        //               icon: Icon(Icons.search),
        //               onPressed: () {
        //                 setState(() {
        //                   _searchBoolean = true;
        //                   _searchIndexList = [];
        //                 });
        //               })
        //         ]
        //       : [
        //           IconButton(
        //               icon: Icon(Icons.clear),
        //               onPressed: () {
        //                 setState(() {
        //                   _searchBoolean = false;
        //                 });
        //               })
        //         ],
        //   elevation: 10,
        //   bottomOpacity: 1,
        //   leading: Icon(Icons.account_balance_wallet_outlined),
        //   foregroundColor: Colors.white,
        //   automaticallyImplyLeading: true,
        // ),

        body: Column(
      children: [
        customAppBar(context),

        Container(), // just a filler

        Container(
          padding:const EdgeInsets.all(5),
          decoration:const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: MediaQuery.of(context).size.height * 0.4,
          child:const GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
        ),
        Container(
          height: 35,
          color: Colors.grey,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: const Text(
                  "Fav locations ",
                ),
              ),
              const Text(
                "Add",
              )
            ],
          ),
        ),
        const ListTile(
          leading: Padding(
            child: Icon(
              Icons.location_city,
            ),
            padding: EdgeInsets.all(10),
          ),
          title: Text(
            "Home",
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          textColor: Colors.grey,
          subtitle: Text("Tap to set"),
          trailing: Icon(Icons.navigate_next),
        ),
        const ListTile(
          leading: Padding(
            child: Icon(
              Icons.location_history_outlined,
            ),
            padding: EdgeInsets.all(10),
          ),
          title: Text(
            "Work",
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          textColor: Colors.grey,
          subtitle: Text("Tap to set"),
          trailing: Icon(Icons.navigate_next),
        ),
        Container(
          height: 35,
          color: Colors.grey,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child:const Text(
                  "Take ride!",
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading:const Padding(
            child: Icon(
              Icons.local_taxi_outlined,
            ),
            padding: EdgeInsets.all(10),
          ),
          title:const Text(
            "Book a private ride",
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          textColor: Colors.grey,
          subtitle:const Text("Tap to oder"),
          trailing:const Icon(Icons.navigate_next),
          onTap: () => navigateToPrepareRide(context),
        ),
      ],
    )

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Stack customAppBar(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: [
            Container(
              // Background
              child:const Center(
                child: Text(
                  "Traveller Red",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              color: Colors.red,
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              // color: Colors.red,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration:const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
            )
          ],
        ),

        Container(), // Required some widget in between to float AppBar

        Positioned(
          // To take AppBar Size only
          top: 95,
          left: 20,
          right: 20,
          child: AppBar(
            elevation: 20,
            automaticallyImplyLeading: true,
            toolbarHeight: 45,
            backgroundColor: Colors.white,
            leading:const Icon(
              Icons.menu,
              color: Colors.red,
            ),
            primary: false,
            title: _searchBoolean
                ? _searchTextField()
                :const TextField(
                    decoration: InputDecoration(
                        hintText: "Search Destination",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey))),
            actions: <Widget>[
              _searchBoolean
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _searchBoolean = false;
                        });
                      },
                      icon:const Icon(Icons.clear, color: Colors.red))
                  : IconButton(
                      icon:const Icon(Icons.search, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _searchBoolean = true;
                          _searchIndexList = [];
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const SearchPage()));
                        });
                      },
                    ),
            ],
          ),
        )
      ],
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Seach destination"),
        elevation: 10,
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
          // Container(
          //     height: MediaQuery.of(context).size.height,
          //     width: MediaQuery.of(context).size.width,
          //     decoration: BoxDecoration(
          //         image: DecorationImage(
          //             image: AssetImage("assets/image/bg.jpg"),
          //             fit: BoxFit.fitHeight,
          //             opacity: 0.5))),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.22,
                child: Row(
                  children: [
                    SizedBox(
                      // color: Colors.pink,
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Column(
                        children: [
                          SizedBox(
                            // color: Colors.brown,
                            height: MediaQuery.of(context).size.height * 0.22,
                            child: Image.asset(
                                "assets/image/icons8-destination-62.png"),
                          ),
                        ],
                      ),
                    ), // for left side icons
                    SizedBox(
                      // color: Colors.blueGrey,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        children: [
                          SizedBox(
                            // color: Colors.red,
                            height: MediaQuery.of(context).size.height * 0.11,
                            child:const Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 20, top: 20),
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: "Source",
                                    // hintText: "Source",
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 10)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                    ),
                                    suffixIcon: Icon(Icons.fmd_good_sharp),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            // color: Colors.pink,
                            height: MediaQuery.of(context).size.height * 0.11,
                            child:const Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 20, bottom: 20),
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: "Destination",
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 10)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                    ),
                                    suffixIcon: Icon(Icons.fmd_good_sharp),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ) // for right side text fields
                  ],
                ),
              ),
              locateAndSavedLocationWidget(context),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(144, 252, 0, 0), //

                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      // height: MediaQuery.of(context).size.height * 0.56,
                      child: SingleChildScrollView(
                        child: Column(
                          // changing widget
                          children: [
                            const Align(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 10, left: 10),
                                  child: Text("Recent searches",
                                      style: TextStyle(fontSize: 15)),
                                ),
                                alignment: Alignment.centerLeft),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                              endIndent: 20,
                              indent: 10,
                            ),
                            ListView(
                              shrinkWrap: true,
                            ),
                            IconButton(
                                onPressed: () {},
                                iconSize: 80,
                                icon:
                                    Image.asset("assets/image/passenger.png")),
                            const Align(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 10, left: 10),
                                  child: Text("Bus stops near you",
                                      style: TextStyle(fontSize: 15)),
                                ),
                                alignment: Alignment.centerLeft),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                              endIndent: 20,
                              indent: 10,
                            ),
                            ListView(
                              shrinkWrap: true,
                            ),
                            IconButton(
                                onPressed: () {},
                                iconSize: 80,
                                icon: Image.asset("assets/image/bus-stop.png")),
                            const Align(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 10, left: 10),
                                  child: Text("Metro station nea you",
                                      style: TextStyle(fontSize: 15)),
                                ),
                                alignment: Alignment.centerLeft),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                              endIndent: 20,
                              indent: 10,
                            ),
                            ListView(
                              shrinkWrap: true,
                            ),
                            IconButton(
                                onPressed: () {},
                                iconSize: 80,
                                icon: Image.asset("assets/image/subway.png")),
                          ],
                        ),
                      )),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  SizedBox locateAndSavedLocationWidget(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      // color: Colors.grey,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 5, top: 0, bottom: 5),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset("assets/image/gps.png")),
                  const Text("Locate self")
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 30, top: 0, bottom: 5),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset("assets/image/save.png"),
                    iconSize: 2,
                  ),
                  const Text("Saved Location")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
