import 'package:busoptimizer/screens/bus_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:busoptimizer/helpers/user_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:busoptimizer/screens/bus_list.dart';
import 'package:busoptimizer/ui/splash.dart';

import 'login_screens/login_screen.dart';
import 'login_screens/registration_screen.dart';
import 'login_screens/welcome_screen.dart';
import 'screens/home.dart';
import 'screens/mode_select.dart';
import 'screens/prepare_ride.dart';
import 'screens/review_ride.dart';
import 'screens/turn_by_turn.dart';

late SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final _auth = FirebaseAuth.instance;
  final user = _auth.currentUser;
  final String initialRoute = (user == null) ? WelcomeScreen.id : Splash.id;

  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();

  await dotenv.load(fileName: "assets/config/.env");
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.initialRoute}) : super(key: key);
  final String initialRoute;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Splash.id: (context) => const Splash(),
        LoginScreen.id: (context) => const LoginScreen(),
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        Home.id: (context) => const Home(),
        PrepareRide.id: (context) =>
            const PrepareRide(userMode: UserMode.passengerMode),
        ModeSelector.id: (context) => const ModeSelector(),
        ReviewRide.id: (context) => const ReviewRide(modifiedResponse: {},),
        TurnByTurn.id: (context) => const TurnByTurn(),
        BusListView.id: (context) => const BusListView(),
        BusId.id: (context) => const BusId()

      },
      initialRoute: initialRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
