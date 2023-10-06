import 'package:flutter/material.dart';
import 'package:housemateheaven/widget/navdrawer2.dart';
import '../widget/navdrawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Search2 extends StatefulWidget {
  const Search2({Key? key}) : super(key: key);

  @override
  State<Search2> createState() => _Search2State();
}

class _Search2State extends State<Search2> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];

  void _performSearch(String query) {
    String startRange = query;
    String endRange = query + '\uf8ff';

    FirebaseFirestore.instance
        .collection('post')
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer2(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Search'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Enter house name',
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
                DocumentSnapshot postSnapshot = _searchResults[index];

                // Extract post data from the snapshot
                String house = postSnapshot['house'];
                String address = postSnapshot['address'];
                String amount = postSnapshot['amount'];
                String money = postSnapshot['money'];
                String phoneno = postSnapshot['phone no'];
                String usercaller = postSnapshot['user caller'];

                // Display the post data in a Card
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}