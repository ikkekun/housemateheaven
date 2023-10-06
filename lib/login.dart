import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housemateheaven/forgetpassword.dart';
import 'package:housemateheaven/pages_student/homepage.dart';
import 'package:housemateheaven/register.dart';
import 'package:housemateheaven/role.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'pages_admin/admin_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isAdmin = false;
  static const String defaultAdminEmail = "adminhh@gmail.com";
  static const String defaultAdminPassword = "adminhh1234";

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Future<void> checkIfUserIsAdmin(User user) async {
    try {
      DocumentSnapshot adminSnapshot = await FirebaseFirestore.instance
          .collection('admin')
          .doc('admin')
          .get();

      if (adminSnapshot.exists) {
        String adminEmail = adminSnapshot['email'];

        setState(() {
          _isAdmin = user.email == adminEmail;
        });
      }
    } catch (e) {
      print('Error checking if user is admin: $e');
    }
  }

  Future<void> signIn() async {
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      if (email == defaultAdminEmail && password == defaultAdminPassword) {
        setState(() {
          _isAdmin = true;
        });
      } else {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        checkIfUserIsAdmin(userCredential.user!);
      }

      if (_isAdmin) {
        // Redirect the admin user to a specific page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Admin()),
        );
      } else {
        // Redirect regular users to a different page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Role()),
        );
      }
    } catch (e) {
      // Handle login errors
      print('Error logging in: $e');
    }
  }

  void navigateToRegisterPage() {
    // Call the callback function to navigate to the register page
    widget.showRegisterPage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(image: AssetImage('assests/image/logowhite.jpeg')),
                Form(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            labelText: "Email",
                            hintText: "Email",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        TextField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            labelText: "Password",
                            hintText: "password",
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: togglePasswordVisibility,
                              icon: Icon(_isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgetPassword(),
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            shadowColor: Colors.black,
                            color: Colors.black,
                            elevation: 7,
                            child: GestureDetector(
                              onTap: signIn,
                              child: Center(
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: navigateToRegisterPage,
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}