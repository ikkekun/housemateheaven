import 'package:flutter/material.dart';
import 'package:housemateheaven/text_box.dart';
import 'package:housemateheaven/widget/navdrawer2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentProfile2 extends StatefulWidget {
  const StudentProfile2({Key? key}) : super(key: key);

  @override
  State<StudentProfile2> createState() => _StudentProfile2State();
}

class _StudentProfile2State extends State<StudentProfile2> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final usersCollection = FirebaseFirestore.instance.collection("users");

  String username = '';
  String fullName = '';
  String password = '';
  String universityName = '';
  String universityId = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final snapshot = await usersCollection.doc(currentUser!.uid).get();
    final userData = snapshot.data() as Map<String, dynamic>?;

    if (userData != null) {
      setState(() {
        username = userData['username'] ?? '';
        fullName = userData['full name'] ?? '';
        password = userData['password'] ?? '';
        universityName = userData['university name'] ?? '';
        universityId = userData['university id'] ?? '';
      });
    }
  }

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );

    if (newValue.trim().length > 0) {
      await usersCollection.doc(currentUser!.uid).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Student Profile'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: usersCollection.doc(currentUser!.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          else{

          final userData = snapshot.data!.data() as Map<String, dynamic>?;

    return ListView(
      children: [
        const SizedBox(height: 50),
              Icon(
                Icons.person,
                size: 72,
              ),
              Text(
                currentUser?.email ?? 'N/A',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[700]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  " Details ",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),

        MyTextBox(
          text: username,
          sectionName: 'username',
          onPressed: () => editField('username'),
        ),
        MyTextBox(
          text: fullName,
          sectionName: 'full name',
          onPressed: () => editField('full name'),
        ),
        MyTextBox(
          text: password,
          sectionName: 'password',
          onPressed: () => editField('password'),
        ),
        MyTextBox(
          text: universityName,
          sectionName: 'university name',
          onPressed: () => editField('university name'),
        ),
        MyTextBox(
          text: universityId,
          sectionName: 'university id',
          onPressed: () => editField('university id'),
        ),
            ],
          );
          }
        },
      ),
    );
  }
}