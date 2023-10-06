import 'package:flutter/material.dart';
import 'package:housemateheaven/pages_student/post.dart';
import 'package:housemateheaven/post_model.dart';
import 'package:provider/provider.dart';
import 'package:housemateheaven/pages_student/list.dart';

class EditPost extends StatefulWidget {
  final String postId;

  EditPost({required this.postId});

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  PostService _postService = PostService();
  TextEditingController _houseController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _moneyController = TextEditingController();
  TextEditingController _phonenoController = TextEditingController();
  TextEditingController _usercallerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch the post details using the postId
    _fetchPostDetails();
  }

  Future<void> _fetchPostDetails() async {
    try {
      PostModel post = await _postService.getPostById(widget.postId);
      if (post != null) {
        // Set the fetched post details to the respective text controllers
        _houseController.text = post.house;
        _addressController.text = post.address;
        _amountController.text = post.amount;
        _moneyController.text = post.money;
        _phonenoController.text = post.phoneno;
        _usercallerController.text = post.usercaller;
      }
    } catch (e) {
      print('Error fetching post details: $e');
    }
  }

  Future<void> _updatePost() async {
    try {
      // Retrieve the updated values from the text controllers
      String updatedHouse = _houseController.text;
      String updatedAddress = _addressController.text;
      String updatedAmount = _amountController.text;
      String updatedMoney = _moneyController.text;
      String updatedphoneno = _phonenoController.text;
      String updatedusercaller = _usercallerController.text;

      // Call the post service to update the post
      await _postService.updatePost(widget.postId, updatedHouse, updatedAddress, updatedAmount, updatedMoney, updatedphoneno, updatedusercaller);

      // Show a success message or perform any necessary actions after updating the post
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Post updated successfully.'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back to the previous screen
      Navigator.pop(context);
    } catch (e) {
      // Handle any error that occurred during the update process
      print('Error updating post: $e');
      // Show an error message or perform any necessary error handling
    }
  }

  @override
  void dispose() {
    _houseController.dispose();
    _addressController.dispose();
    _amountController.dispose();
    _moneyController.dispose();
    _phonenoController.dispose();
    _usercallerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Edit Post'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _houseController,
              decoration: InputDecoration(labelText: 'House'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount Housemate Needed'),
            ),
            TextField(
              controller: _moneyController,
              decoration: InputDecoration(labelText: 'Expected Rental Amount(RM)'),
            ),
            TextField(
              controller: _usercallerController,
              decoration: InputDecoration(labelText: 'Posted by'),
            ),
            TextField(
              controller: _phonenoController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updatePost,
              child: Text('Update Post'),
            ),
          ],
        ),
      ),
    );
  }
}