import 'package:flutter/material.dart';
import 'package:temp/homepage.dart';
import '../screens/home.dart';

class ModeSelector extends StatelessWidget {
  static const String id = "ModeSelectorScreen";
  const ModeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
            Container(
              height: 70,
              width: 200,
              margin: const EdgeInsets.all(20),
              child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context,Home.id), 
                  child: const Text("Driver Mode"),
                ),
            ),
            Container(
              height: 70,
              width: 200,
              margin: const EdgeInsets.all(20),              
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context,HomePage.id), 
                child: const Text("Passenger Mode"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
