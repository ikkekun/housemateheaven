import 'package:flutter/material.dart';

import '../post_model.dart';

class FavoritePostsProvider extends ChangeNotifier {
  List<PostModel> favoritePosts = [];
  List<String> bookmarkedPostIds = [];

    void toggleBookmark(PostModel post) {
    if (bookmarkedPostIds.contains(post.id)) {
      bookmarkedPostIds.remove(post.id);
      favoritePosts.removeWhere((favPost) => favPost.id == post.id);
    } else {
      bookmarkedPostIds.add(post.id);
      favoritePosts.add(post);
    }
    notifyListeners();
  }

  void addFavoritePost(PostModel post) {
    bookmarkedPostIds.add(post.id);
    favoritePosts.add(post);
    notifyListeners();
  }

  void removeFavoritePost(PostModel post) {
    bookmarkedPostIds.remove(post.id);
    favoritePosts.remove(post);
    notifyListeners();
  }
  
}