import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_nwesapp/modules/shop_app/onboarding/onboarding.dart';
import 'package:lottie/lottie.dart';
class LottiScreen extends StatefulWidget {
  @override
  _LottiScreenState createState() => _LottiScreenState();
}
class _LottiScreenState extends State<LottiScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(milliseconds:3150),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => OnBoardingScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:Center(
          child: Container(
            child: Lottie.asset(
                'assets/splash.json',
            ),
          ),
        ),
      ),
    );
  }
}

