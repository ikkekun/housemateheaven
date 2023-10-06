import 'package:flutter/material.dart';
import 'package:housemateheaven/widget/navdrawer2.dart';
import '../post_model.dart';
import '../widget/navdrawer2.dart';
import 'favourite_provider.dart';
import 'package:provider/provider.dart';

class Favourite extends StatelessWidget {
  const Favourite({Key? key, required List favoritePosts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoritePostsProvider = Provider.of<FavoritePostsProvider>(context);
    final favoritePosts = favoritePostsProvider.favoritePosts;

    return Scaffold(
      drawer: NavDrawer2(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Favourite'),
      ),
      body: ListView.builder(
        itemCount: favoritePosts.length,
        itemBuilder: (context, index) {
          final post = favoritePosts[index];

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
              ),
            ),
          );
        },
      ),
    );
  }
}