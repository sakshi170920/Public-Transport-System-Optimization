import 'package:busoptimizer/screens/home.dart';
import 'package:flutter/material.dart';

Widget reviewRideFaButton(BuildContext context) {
  return FloatingActionButton.extended(
      icon: const Icon(Icons.local_taxi),
      onPressed: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    const Home()));
      },
      label: const Text('Review Ride'));
}
