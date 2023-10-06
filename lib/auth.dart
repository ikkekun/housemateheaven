import 'package:flutter/material.dart';
import 'package:housemateheaven/login.dart';
import 'package:housemateheaven/register.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {

  bool showLoginPage = true;

  void toggleScreens(){
    setState(() {
      showLoginPage =! showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
   if (showLoginPage){
    return LoginPage(showRegisterPage: toggleScreens);
   } else {
    return RegisterPage(showLoginPage: toggleScreens);
   }
  }
}