import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:temp/helpers/user_mode.dart';
import 'package:temp/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp/screens/bus_list.dart';
import 'package:temp/ui/splash.dart';

import 'screens/home.dart';
import 'screens/mode_select.dart';
import 'screens/prepare_ride.dart';
import 'screens/review_ride.dart';
import 'screens/turn_by_turn.dart';

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
  runApp(const MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key,required this.initialRoute}) : super(key: key);
  final String initialRoute;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Splash.id:(context) => const Splash(),
        Home.id : (context) => const Home(),
        HomePage.id: (context) => const HomePage(title: 'Traveller'),
        PrepareRide.id :(context) => const PrepareRide(userMode: UserMode.passengerMode),
        ModeSelector.id :(context) => const ModeSelector(),
        ReviewRide.id :(context) => const ReviewRide(modifiedResponse: {}),
        TurnByTurn.id :(context) => const TurnByTurn(),
        BusListView.id : (context) => const BusListView()
      },
      initialRoute: initialRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
