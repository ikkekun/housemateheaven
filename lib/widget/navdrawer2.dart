import 'package:flutter/material.dart';
import 'package:housemateheaven/login.dart';
import 'package:housemateheaven/main.dart';
import 'package:housemateheaven/pages_studentrent/favourite.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housemateheaven/pages_studentrent/homepage2.dart';
import 'package:housemateheaven/pages_studentrent/search2.dart';
import 'package:housemateheaven/pages_studentrent/shootout2.dart';
import 'package:housemateheaven/pages_studentrent/studentprofile2.dart';


class NavDrawer2 extends StatelessWidget {
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
                        builder: (context) => const HomePage2(),
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
                        builder: (context) => ShootOut2(),
                      ),
                    );
                  },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search'),
            onTap: () {
                    //Open search page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Search2(),
                      ),
                    );
                  },
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Favourite'),
            onTap: () {
                    //Open bookmark
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Favourite(favoritePosts: [],),
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
                        builder: (context) => const StudentProfile2(),
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