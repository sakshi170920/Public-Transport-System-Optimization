import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    child: Image.asset('assets/image/logo.png'),
                    height: 60.0,
                  ),
                ),
                SizedBox(
                  width: 250.0,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'Bobbers',
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText('OptiBus',
                            textStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: MaterialButton(
                minWidth: 200.0,
                height: 42.0,
                color: Colors.lightBlueAccent,
                child: const Text(
                  'Log In',
                ),
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: MaterialButton(
                minWidth: 200.0,
                height: 42.0,
                color: Colors.lightBlueAccent,
                child: const Text(
                  'Register',
                ),
                onPressed: () =>
                    {Navigator.pushNamed(context, RegistrationScreen.id)},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
