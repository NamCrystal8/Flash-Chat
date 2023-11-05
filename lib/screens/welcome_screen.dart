import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../components/navigator_button.dart';
import '../firebase_options.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = '/';
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
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = ColorTween(begin: Colors.red, end: Colors.greenAccent)
        .animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
    fireBase();

  }
  void fireBase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('Flash Chat',
                        textStyle: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                        ),
                        speed: const Duration(milliseconds: 300)),
                  ],
                  isRepeatingAnimation: false,
                )
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            NaviButton(
                text: 'Log In',
                route: LoginScreen.id,
                color: Colors.lightBlueAccent),
            NaviButton(
                text: 'Register',
                route: RegistrationScreen.id,
                color: Colors.blueAccent)
          ],
        ),
      ),
    );
  }
}
