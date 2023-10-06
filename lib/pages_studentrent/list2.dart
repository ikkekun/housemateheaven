import 'package:flutter/material.dart';
import 'package:housemateheaven/pages_student/edit_post.dart';
import 'package:housemateheaven/pages_studentrent/post2.dart';
import 'package:housemateheaven/pages_studentrent/post_details.dart';
import 'package:housemateheaven/pages_student/post.dart';
import 'package:housemateheaven/post_model.dart';
import 'package:provider/provider.dart';

import 'favourite_provider.dart';

class ListPost2 extends StatefulWidget {
  const ListPost2({Key? key}) : super(key: key);

  @override
  State<ListPost2> createState() => _ListPostState();
}

class _ListPostState extends State<ListPost2> {
  PostService2 _postService = PostService2();
  List<String> bookmarkedPostIds = []; // List to store the IDs of bookmarked posts

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<PostModel>>(context);
    final favoritePostsProvider = Provider.of<FavoritePostsProvider>(context);

    bookmarkedPostIds = favoritePostsProvider.bookmarkedPostIds;

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        final isBookmarked = bookmarkedPostIds.contains(post.id); // Check if the post is bookmarked

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
                    'Amount Housemate Needed: ${post.amount}',
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
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: isBookmarked ? Colors.orange : null,
                    ),
                    onPressed: () {
                      favoritePostsProvider.toggleBookmark(post);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}