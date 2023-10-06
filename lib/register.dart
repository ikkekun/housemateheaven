import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housemateheaven/login.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({
    Key? key,
    required this.showLoginPage,
    }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();
  final TextEditingController _uninameController = TextEditingController();
  final TextEditingController _uniidController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose(){
    _fullnameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _uninameController.dispose();
    _uniidController.dispose();

    super.dispose();
  }

  Future<void> signUp() async {
  try {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await addUserDetails(
        _fullnameController.text.trim(),
        _usernameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _uninameController.text.trim(),
        _uniidController.text.trim(),
      );
    }
  } catch (e, stackTrace) {
    print('Error during sign up: $e');
    print('Stack trace: $stackTrace');
  }
}

  bool passwordConfirmed(){
    if(_passwordController.text.trim() ==
      _confirmpasswordController.text.trim()) {
        return true;
      } else {
        return false;
      }
  }

  Future addUserDetails(String fullName, String username, String email, String password, String uniName, String uniID) async {
    await FirebaseFirestore.instance.collection('users').add({
      'full name': fullName,
      'username': username,
      'email': email,
      'password': password,
      'university name': uniName,
      'university id': uniID,
    });
  }

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child : Scaffold(
      body : SingleChildScrollView(
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
              children: <Widget>[
                TextField(
                      controller: _fullnameController,
                      decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_outlined),
                      labelText: "Full Name",
                      hintText: "Full Name",
                      border: OutlineInputBorder(),
                      ),
                    ),
                  const SizedBox(height: 30.0),
                TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_outlined),
                      labelText: "Username",
                      hintText: "Username",
                      border: OutlineInputBorder(),
                      ),
                    ),
                  const SizedBox(height: 30.0),
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
                  const SizedBox(height: 30.0),
                TextField(
                          controller: _confirmpasswordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            labelText: "Password Confirmation",
                            hintText: "Password Confirmation",
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: togglePasswordVisibility,
                              icon: Icon(_isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                        ),
                  const SizedBox(height: 30.0),
                TextField(
                      controller: _uninameController,
                      decoration: InputDecoration(
                      prefixIcon: Icon(Icons.school_outlined),
                      labelText: "University Name",
                      hintText: "University Name",
                      border: OutlineInputBorder(),
                      ),
                    ),
                  const SizedBox(height: 30.0),
                TextField(
                      controller: _uniidController,
                      decoration: InputDecoration(
                      prefixIcon: Icon(Icons.school),
                      labelText: "University ID",
                      hintText: "University ID",
                      border: OutlineInputBorder(),
                      ),
                    ),
                  const SizedBox(height: 30.0),
                Container(
                  height: 40,
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    shadowColor: Colors.black,
                    color: Colors.black,
                    elevation: 7,
                    child: GestureDetector(
                      onTap: signUp,
                      child: Center(
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'
                          ),
                        ),
                      ),
                    )
                  ),
                ),
                 const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: widget.showLoginPage,
                      child: Text(
                        'Return to Login Page',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold
                        ),
                      )
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
    )
      )
    );
  }
}
