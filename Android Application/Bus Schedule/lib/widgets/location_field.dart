import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import '../requests/mapbox_driver.dart';
import '../screens/prepare_ride.dart';

import '../helpers/mapbox_handler.dart';
import '../helpers/shared_prefs.dart';
import '../main.dart';

class LocationField extends StatefulWidget {
  final bool isDestination;
  final TextEditingController textEditingController;
  const LocationField({
    Key? key,
    required this.isDestination,
    required this.textEditingController,
  }) : super(key: key);

  @override
  State<LocationField> createState() => _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
  Timer? searchOnStoppedTyping;
  String query = '';

  _onChangeHandler(value) {
    // Set isLoading = true in parent
    PrepareRide.of(context)?.isLoading = true;

    // Make sure that requests are not made
    // until 1 second after the typing stops
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping?.cancel());
    }
    setState(() => searchOnStoppedTyping =
        Timer(const Duration(seconds: 1), () => _searchHandler(value)));
  }

  _searchHandler(String value) async {
    // Get response using Mapbox Search API
    List citiesData = await getAllCities();
    List response = citiesData;

    // Set responses and isDestination in parent
    PrepareRide.of(context)?.responsesState = response;
    PrepareRide.of(context)?.isResponseForDestinationState =
        widget.isDestination;
    setState(() => query = value);
  }


  @override
  Widget build(BuildContext context) {
    String placeholderText = widget.isDestination ? 'Where to?' : 'Where from?';
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10),
      child: CupertinoTextField(
          controller: widget.textEditingController,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          placeholder: placeholderText,
          placeholderStyle: GoogleFonts.rubik(color: Colors.indigo[300]),
          decoration: BoxDecoration(
            color: Colors.indigo[100],
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          onChanged: _onChangeHandler,
      )
    );
  }
}
