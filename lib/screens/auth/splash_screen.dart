import 'dart:async';
import 'dart:io';

import 'package:dar_altep/screens/auth/splash_language_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() async{
    // TODO: implement initState
    super.initState();
    // Firebase.initializeApp();
    // if (Platform.isIOS){
    //   FirebaseMessaging.instance.requestPermission(
    //     alert: true,
    //     badge: true,
    //     sound: true,
    //     announcement: false,
    //     carPlay: false,
    //     criticalAlert: false,
    //     provisional: false,
    //   );
    // }

    // just for testing get countries request
    // Provider.of<UserDataController>(context,listen: false).fetchCountries();
    Timer(
      const Duration(milliseconds: 1000),
      () {
        Navigator.push(context, FadeRoute(page: const SplashLanguageScreen()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/splashBackGround.png"),
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.25), BlendMode.dstATop),
            fit: BoxFit.fill,
          ),
        ),
        child: const Center(
          child: Image(
            image: AssetImage(
              'assets/images/logo.png',
            ),
            fit: BoxFit.contain,
            height: 270,
            width: 270,
          ),
        ),
      ),
    );
  }
}
