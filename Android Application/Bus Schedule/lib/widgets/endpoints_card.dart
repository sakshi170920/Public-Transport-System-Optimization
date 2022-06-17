import 'package:flutter/material.dart';
import 'package:temp/helpers/user_mode.dart';

import 'location_field.dart';

Widget endpointsCard(UserMode userMode,TextEditingController sourceController,
    TextEditingController destinationController) {
  return Card(
    elevation: 5,
    clipBehavior: Clip.antiAlias,
    margin: const EdgeInsets.all(0),
    child: Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Column(
            children: [
              const Icon(Icons.brightness_1, size: 8),
              Container(
                margin: const EdgeInsets.only(top: 3),
                color: Colors.black,
                width: 1,
                height: 40,
              ),
              const Icon(Icons.stop, size: 12),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                LocationField(
                    userMode: userMode,
                    isDestination: false,
                    textEditingController: sourceController),
                LocationField(
                    userMode: userMode,
                    isDestination: true,
                    textEditingController: destinationController),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
