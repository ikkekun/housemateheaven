import 'package:flutter/material.dart';
import 'package:housemateheaven/post_model.dart';

class PostDetails extends StatelessWidget {
  final PostModel post;

  const PostDetails({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implement the UI for displaying the post details
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Post ID: ${post.id}'),
            Text('House: ${post.house}'),
            Text('Address: ${post.address}'),
            Text('Amount: ${post.amount}'),
            Text('Money: ${post.money}'),
            Text('Phone Number: ${post.phoneno}'),
            Text('Name: ${post.usercaller}'),
          ],
        ),
      ),
    );
  }
}