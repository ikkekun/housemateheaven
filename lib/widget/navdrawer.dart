import 'package:flutter/material.dart';
import 'package:housemateheaven/login.dart';
import 'package:housemateheaven/main.dart';
import 'package:housemateheaven/pages_student/homepage.dart';
import 'package:housemateheaven/pages_student/shootout.dart';
import 'package:housemateheaven/pages_student/studentprofile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.black,
                ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Homepage'),
            onTap: () {
                    //Open home page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
          ),
          ListTile(
            leading: Icon(Icons.campaign),
            title: Text('ShootOut'),
            onTap: () {
                    //Open shootout
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShootOut(),
                      ),
                    );
                  },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () {
                    //Open profile page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StudentProfile(),
                      ),
                    );
                  },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage(showRegisterPage: () {  },)),
                  (Route<dynamic> route) => false,
                );
              }).catchError((error) {
                print('Logout error: $error');
              });
            },
          ),
        ],
      ),
    );
  }
}