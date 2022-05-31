import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:temp/driver.dart';
import 'package:temp/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp/ui/splash.dart';

late SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //final _auth = FirebaseAuth.instance;
  //final user = await _auth.currentUser();
  //final String initialRoute = (user == null) ? WelcomeScreen.id : HomePage.id;
  const String initialRoute = Splash.id;
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await dotenv.load(fileName: "assets/config/.env");
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  MyApp({required this.initialRoute});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomePage.id: (context) => const HomePage(title: 'Traveller'),
        Driver.id: (context) => const Driver(),
        Splash.id:(context) => const Splash()
      },
      initialRoute: initialRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
