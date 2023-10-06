import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditUserPage extends StatefulWidget {
  final DocumentSnapshot userSnapshot;

  const EditUserPage({Key? key, required this.userSnapshot}) : super(key: key);

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _uniNameController = TextEditingController();
  TextEditingController _uniIDController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with the current user information
    _emailController.text = widget.userSnapshot['email'];
    _usernameController.text = widget.userSnapshot['username'];
    _fullNameController.text = widget.userSnapshot['full name'];
    _passwordController.text = widget.userSnapshot['password'];
    _uniNameController.text = widget.userSnapshot['university name'];
    _uniIDController.text = widget.userSnapshot['university id'];
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _fullNameController.dispose();
    _passwordController.dispose();
    _uniNameController.dispose();
    _uniIDController.dispose();
    super.dispose();
  }

  void _updateUser() {
    // Get the updated values from the text controllers
    String updatedEmail = _emailController.text.trim();
    String updatedUsername = _usernameController.text.trim();
    String updatedFullName = _fullNameController.text.trim();
    String updatedPassword = _passwordController.text.trim();
    String updatedUniName = _uniNameController.text.trim();
    String updatedUniID = _uniIDController.text.trim();

    // Update the user document in Firestore
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userSnapshot.id)
        .update({
      'email': updatedEmail,
      'username': updatedUsername,
      'full name': updatedFullName,
      'password': updatedPassword,
      'university name': updatedUniName,
      'university id': updatedUniID,
    }).then((value) {
      // Show a success message or navigate back to the previous screen
      print('User updated successfully');
      Navigator.pop(context); // Navigate back to the previous screen
    }).catchError((error) {
      // Show an error message
      print('Error updating user: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.black,
      title: Text('Edit User'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextField(
              controller: _uniNameController,
              decoration: InputDecoration(labelText: 'University Name'),
            ),
            TextField(
              controller: _uniIDController,
              decoration: InputDecoration(labelText: 'University ID'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateUser,
              child: Text('Update User'),
            ),
          ],
        ),
      ),
    ),
  );
}
}