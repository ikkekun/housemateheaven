import 'package:flutter/material.dart';
import 'package:housemateheaven/pages_student/rentalform.dart';
import 'package:housemateheaven/pages_studentrent/list2.dart';
import 'package:housemateheaven/pages_studentrent/post2.dart';
import 'package:housemateheaven/pages_student/post.dart';
import 'package:housemateheaven/widget/navdrawer2.dart';
import '../pages_student/list.dart';
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

class ShootOut2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postService = PostService2();

    return StreamProvider<List<PostModel>>.value(
      value: postService.getPostsByUser(FirebaseAuth.instance.currentUser?.uid ?? ''),
      initialData: [],
      child: Scaffold(
        drawer: NavDrawer2(), // Make sure you have implemented NavDrawer correctly
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('ShootOut'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListPost2(),
            ),
          ],
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