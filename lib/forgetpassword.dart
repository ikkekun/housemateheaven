import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housemateheaven/login.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();

}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController forgetPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Forget Password'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 250.0,
              child: Image.asset('assests/image/logowhite.jpeg'),
            ),
            SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                controller: forgetPasswordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email',
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () async {
                var forgotEmail = forgetPasswordController.text.trim();

                try {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: forgotEmail)
                      .then((value) => {
                            print("Email Sent"),
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(showRegisterPage: () {  },),
                              ),
                            ),
                          });
                } on FirebaseAuthException catch (e) {
                  print("Error $e");
                }
              },
              child: Text("Forgot Password"),
            ),
          ],
        ),
      ),
    );
  }
}