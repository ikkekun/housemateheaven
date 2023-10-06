import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditPostPage extends StatefulWidget {
  final DocumentSnapshot postSnapshot;

  const EditPostPage({Key? key, required this.postSnapshot}) : super(key: key);

  @override
  _EditPostPageState createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  TextEditingController _houseController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _moneyController = TextEditingController();
  TextEditingController _usercallerController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize the text controllers with the existing post data
    _houseController.text = widget.postSnapshot['house'];
    _addressController.text = widget.postSnapshot['address'];
    _amountController.text = widget.postSnapshot['amount'];
    _moneyController.text = widget.postSnapshot['money'];
    _usercallerController.text = widget.postSnapshot['user caller'];
  }

  @override
  void dispose() {
    // Dispose the text controllers
    _houseController.dispose();
    _addressController.dispose();
    _amountController.dispose();
    _moneyController.dispose();
    _usercallerController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    // Get the updated values from the text controllers
    String updatedHouse = _houseController.text;
    String updatedAddress = _addressController.text;
    String updatedAmount = _amountController.text;
    String updatedMoney = _moneyController.text;
    String updatedusercaller = _usercallerController.text;

    // Update the post data in the Firestore database
    String postId = widget.postSnapshot.id;
    FirebaseFirestore.instance
        .collection('post')
        .doc(postId)
        .update({
      'house': updatedHouse,
      'address': updatedAddress,
      'amount': updatedAmount,
      'money': updatedMoney,
      'usercaller':updatedusercaller,
    }).then((_) {
      print('Post updated successfully');
      // Show a success message or navigate back to the previous screen
    }).catchError((error) {
      print('Error updating post: $error');
      // Show an error message or handle the error appropriately
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Edit Post'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('House:'),
              TextField(
                controller: _houseController,
              ),
              SizedBox(height: 16.0),
              Text('Address:'),
              TextField(
                controller: _addressController,
              ),
              SizedBox(height: 16.0),
              Text('Amount Housemate Needed:'),
              TextField(
                controller: _amountController,
              ),
              SizedBox(height: 16.0),
              Text('Posted by:'),
              TextField(
                controller: _usercallerController,
              ),
              SizedBox(height: 16.0),
              Text('Expected Rental Amount(RM):'),
              TextField(
                controller: _moneyController,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveChanges,
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}