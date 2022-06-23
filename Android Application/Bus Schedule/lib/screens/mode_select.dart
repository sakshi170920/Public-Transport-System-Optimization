import 'package:flutter/material.dart';
import '../helpers/user_mode.dart';
import '../screens/home.dart';
import 'prepare_ride.dart';

class ModeSelector extends StatelessWidget {
  static const String id = "ModeSelectorScreen";
  const ModeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Mode")),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 200,
              margin: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, Home.id),
                child: const Text(
                  "Driver Mode",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              height: 70,
              width: 200,
              margin: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const PrepareRide(
                            userMode: UserMode.passengerMode))),
                child: const Text(
                  "Passenger Mode",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
