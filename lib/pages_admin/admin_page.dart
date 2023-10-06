import 'package:flutter/material.dart';
import 'package:housemateheaven/widget/navdrawer_admin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'admin_editpost.dart';
import 'admin_edituser.dart';

enum SearchCategory {
  Post,
  User,
}

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];
  SearchCategory _selectedCategory = SearchCategory.Post;

  void _performSearch(String query) {
    String startRange = query;
    String endRange = query + '\uf8ff';

    CollectionReference collection;
    if (_selectedCategory == SearchCategory.Post) {
      collection = FirebaseFirestore.instance.collection('post');

      collection
        .where('house', isGreaterThanOrEqualTo: startRange)
        .where('house', isLessThan: endRange)
        .get()
        .then((QuerySnapshot snapshot) {
      setState(() {
        _searchResults = snapshot.docs;
      });
    }).catchError((error) {
      print('Error performing search: $error');
    });

    } else {
      collection = FirebaseFirestore.instance.collection('users');

      collection
        .where('email', isGreaterThanOrEqualTo: startRange)
        .where('email', isLessThan: endRange)
        .get()
        .then((QuerySnapshot snapshot) {
      setState(() {
        _searchResults = snapshot.docs;
      });
    }).catchError((error) {
      print('Error performing search: $error');
    });
    }

  }

  void _deletePost(DocumentSnapshot postSnapshot) {
    String postId = postSnapshot.id;

    FirebaseFirestore.instance
        .collection('post')
        .doc(postId)
        .delete()
        .then((value) {
      print('Post deleted successfully');
      setState(() {
        _searchResults.remove(postSnapshot);
      });
    }).catchError((error) {
      print('Error deleting post: $error');
    });
  }

  void _deleteUser(DocumentSnapshot userSnapshot) {
    String userId = userSnapshot.id;

    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .delete()
        .then((value) {
      print('User deleted successfully');
      setState(() {
        _searchResults.remove(userSnapshot);
      });
    }).catchError((error) {
      print('Error deleting user: $error');
    });
  }

  void _editPost(DocumentSnapshot postSnapshot) {
    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditPostPage(postSnapshot: postSnapshot),
    ),
  );
  }

  void _editUser(DocumentSnapshot userSnapshot) {
    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditUserPage(userSnapshot: userSnapshot),
    ),
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawerAdmin(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Adjust'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio<SearchCategory>(
                value: SearchCategory.Post,
                groupValue: _selectedCategory,
                onChanged: (SearchCategory? value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              Text('Post'),
              Radio<SearchCategory>(
                value: SearchCategory.User,
                groupValue: _selectedCategory,
                onChanged: (SearchCategory? value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              Text('User'),
            ],
          ),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Enter house or user name based on what you choose above',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String searchQuery = _searchController.text;
              _performSearch(searchQuery);
            },
            child: Text('Search'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                DocumentSnapshot snapshot = _searchResults[index];

                if (_selectedCategory == SearchCategory.Post) {
                  // Display post data in a Card
                  String house = snapshot['house'];
                  String address = snapshot['address'];
                  String amount = snapshot['amount'];
                  String money = snapshot['money'];
                  String phoneno = snapshot['phone no'];
                  String usercaller = snapshot['user caller'];

                  return Card(
                    child: ListTile(
                      title: Text(house),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Address: $address'),
                          Text('Amount Housemate Needed: $amount'),
                          Text('Expected Rental Amount(RM): $money'),
                          Text('Posted by: $usercaller'),
                          Text('Phone Number: $phoneno'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => _editPost(snapshot),
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () => _deletePost(snapshot),
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  // Display user data in a Card
                  String email = snapshot['email'];
                  String username = snapshot['username'];
                  String fullName = snapshot['full name'];
                  String password = snapshot['password'];
                  String uniName = snapshot['university name'];
                  String uniID = snapshot['university id'];

                  return Card(
                    child: ListTile(
                      title: Text(email),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Username: $username'),
                          Text('Full Name: $fullName'),
                          Text('Password: $password'),
                          Text('University Name: $uniName'),
                          Text('Universiy ID: $uniID'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => _editUser(snapshot),
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () => _deleteUser(snapshot),
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}