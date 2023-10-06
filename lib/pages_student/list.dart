import 'package:flutter/material.dart';
import 'package:housemateheaven/pages_student/edit_post.dart';
import 'package:housemateheaven/pages_student/post.dart';
import 'package:housemateheaven/post_model.dart';
import 'package:provider/provider.dart';

import '../user.dart';
import '../user_model.dart';

class ListPost extends StatefulWidget {
  const ListPost({Key? key}) : super(key: key);

  @override
  State<ListPost> createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  PostService _postService = PostService();
  UserService _userService = UserService();

  Future<void> _deletePost(String postId) async {
    try {
      await _postService.deletePost(postId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Post deleted successfully.'),
          backgroundColor: Colors.green,
        ),
      );

      // Refresh the list of posts
      setState(() {});
    } catch (e) {
      print('Error deleting post: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting post. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _editPost(String postId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPost(postId: postId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<List<PostModel>>(
      builder: (context, posts, _) {
        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return StreamBuilder<UserModel>(
              stream: _userService.getUserInfo(post.user),
              builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final userModel = snapshot.data!;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      title: Text(
                        post.house,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Text(
                            'Address: ${post.address}',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Housemate Needed: ${post.amount}',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Expected Rental Amount(RM): ${post.money}',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Posted by: ${post.usercaller}',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Phone Number: ${post.phoneno}',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _editPost(post.id);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deletePost(post.id);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}