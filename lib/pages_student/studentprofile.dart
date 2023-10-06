import 'package:flutter/material.dart';
import '../widget/navdrawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housemateheaven/text_box.dart';



class StudentProfile extends StatefulWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final usersCollection = FirebaseFirestore.instance.collection("users");

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
                text: userData?['username'] ?? '',
                sectionName: 'username',
                onPressed: () => editField('username'),
              ),
              MyTextBox(
                text: userData?['full name'] ?? '',
                sectionName: 'full name',
                onPressed: () => editField('full name'),
              ),
              MyTextBox(
                text: userData?['password'] ?? '',
                sectionName: 'password',
                onPressed: () => editField('password'),
              ),
              MyTextBox(
                text: userData?['university name'] ?? '',
                sectionName: 'university name',
                onPressed: () => editField('university name'),
              ),
              MyTextBox(
                text: userData?['university id'] ?? '',
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
