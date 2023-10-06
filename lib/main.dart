import 'package:flutter/material.dart';
import 'package:housemateheaven/auth.dart';
import 'package:housemateheaven/pages_student/homepage.dart';
import 'package:housemateheaven/pages_studentrent/homepage2.dart';
import 'package:housemateheaven/post_model.dart';
import 'package:housemateheaven/role.dart';
import 'login.dart';
import 'onboarding.dart';
import 'pages_studentrent/favourite_provider.dart';
import 'register.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritePostsProvider()),
        StreamProvider<List<PostModel>>.value(
          value: FirebaseFirestore.instance
              .collection('post')
              .snapshots()
              .map((QuerySnapshot snapshot) {
            return snapshot.docs.map((DocumentSnapshot doc) {
              return PostModel(
                id: doc.id,
                house: doc['house'],
                address: doc['address'],
                amount: doc['amount'],
                money: doc['money'],
                phoneno: doc['phone no'],
                usercaller: doc['user caller'],
                user: doc['user'],
              );
            }).toList();
          }),
          initialData: [], // Provide an empty list as initial data
        ),
      ],
      child: HousemateHeavenApp(),
    ),
  );
}

class HousemateHeavenApp extends StatelessWidget {
  HousemateHeavenApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final currentUser = snapshot.data;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
              ),
              body: Role(),
            ),
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
              ),
              body: Auth(),
            ),
          );
        }
      },
    );
  }
}