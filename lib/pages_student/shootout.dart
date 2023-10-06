import 'package:flutter/material.dart';
import 'package:housemateheaven/pages_student/rentalform.dart';
import 'package:housemateheaven/pages_student/post.dart';
import 'list.dart';
import '../widget/navdrawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:housemateheaven/post_model.dart';

class ShootOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postService = PostService();
    final user = FirebaseAuth.instance.currentUser;
    
    return StreamProvider<List<PostModel>>.value(
      value: postService.getPostsByUser(user?.uid ?? ''),
      initialData: [], // Provide initial empty list
      child: Scaffold(
        drawer: NavDrawer(), // Make sure you have implemented NavDrawer correctly
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('ShootOut'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListPost(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return RentalForm();
              }),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.black,
          foregroundColor: Colors.yellow,
          mini: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(icon: Icon(Icons.menu), onPressed: () {}),
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}