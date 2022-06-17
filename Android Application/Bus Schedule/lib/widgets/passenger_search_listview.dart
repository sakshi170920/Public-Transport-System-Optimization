import 'dart:convert';

import 'package:flutter/material.dart';

import '../main.dart';

Widget passengerSearchListView(
    List responses,
    bool isResponseForDestination,
    TextEditingController destinationController,
    TextEditingController sourceController) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: responses.length,
    itemBuilder: (BuildContext context, int index) {
      return Column(
        children: [
          ListTile(
            onTap: () {
              String text = responses[index];
              if (isResponseForDestination) {
                destinationController.text = text;
                sharedPreferences.setString(
                    'destination', json.encode(responses[index]));
              } else {
                sourceController.text = text;
                sharedPreferences.setString(
                    'source', json.encode(responses[index]));
              }
              FocusManager.instance.primaryFocus?.unfocus();
            },
            leading: const SizedBox(
              height: double.infinity,
              child: CircleAvatar(child: Icon(Icons.map)),
            ),
            title: Text(responses[index],
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          const Divider(),
        ],
      );
    },
  );
}
