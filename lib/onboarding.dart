import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: (
          Image.asset('assests/image/logoblack.jpeg')
        ),
      ),
    );
  }
}