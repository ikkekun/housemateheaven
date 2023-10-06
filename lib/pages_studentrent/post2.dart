import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:housemateheaven/post_model.dart';

class PostService2 {
  List<PostModel> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PostModel(
        id: doc.id,
        house: doc['house'] ?? '',
        address: doc['address'] ?? '',
        amount: doc['amount'] ?? '',
        money: doc['money'] ?? '',
        phoneno: doc['phone no'] ?? '',
        usercaller: doc['user caller'] ?? '',
        user: doc['user'] ?? '',
      );
    }).toList();
  }

  Future<void> savePost(String house, String address, String amount, String money, String phoneno, String usercaller) async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    // Get the current user's UID
    String uid = currentUser.uid;

    // Create a new document reference in the "post" collection
    DocumentReference postRef = FirebaseFirestore.instance.collection("post").doc();

    // Create a new document reference in the "users" collection with the same ID as the post
    DocumentReference userRef = FirebaseFirestore.instance.collection("users").doc(postRef.id);

    // Batch write to update both collections atomically
    WriteBatch batch = FirebaseFirestore.instance.batch();

    // Set the user document with the post ID
    batch.set(userRef, {});

    // Set the post document with the user ID
    batch.set(postRef, {
      'house': house,
      'address': address,
      'amount': amount,
      'money': money,
      'phone no': phoneno,
      'user caller': usercaller,
      'user': uid,
    });

    // Commit the batch write
    await batch.commit();
  }
}

  Stream<List<PostModel>> getPostsByUser(String uid) {
    return FirebaseFirestore.instance
        .collection("post")
        .snapshots()
        .map(_postListFromSnapshot);
  }

  Future<PostModel> getPostById(String postId) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('post').doc(postId).get();
    return PostModel(
      id: snapshot.id,
      house: snapshot['house'] ?? '',
      address: snapshot['address'] ?? '',
      amount: snapshot['amount'] ?? '',
      money: snapshot['money'] ?? '',
      phoneno: snapshot['phone no'] ?? '',
      usercaller: snapshot['user caller'] ?? '',
      user: snapshot['user'] ?? '',
    );
  }

}