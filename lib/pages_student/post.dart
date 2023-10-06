import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:housemateheaven/post_model.dart';
import 'package:housemateheaven/user_model.dart';

class PostService {
  List<PostModel> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PostModel(
        id: doc.id,
        house: doc['house'] ?? '',
        address: doc['address'] ?? '',
        amount: doc['amount'] ?? '',
        money: doc['money'] ?? '',
        phoneno : doc['phone no']??'',
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

      await FirebaseFirestore.instance.collection("post").add({
        'house': house,
        'address': address,
        'amount': amount,
        'money': money,
        'phone no' : phoneno,
        'user caller': usercaller,
        'user': uid, // Set the user field to the current user's UID
      });
    }
  }


  Stream<List<PostModel>> getPostsByUser(String uid) {
    return FirebaseFirestore.instance
        .collection("post")
        .where('user', isEqualTo: uid)
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

  Future<void> updatePost(String postId, String house, String address, String amount, String money, String phoneno, String usercaller) async {
    await FirebaseFirestore.instance.collection('post').doc(postId).update({
      'house': house,
      'address': address,
      'amount': amount,
      'money': money,
      'phoneno': phoneno,
      'user caller': usercaller,
    });
  }

  Future<void> deletePost(String postId) async {
    await FirebaseFirestore.instance.collection('post').doc(postId).delete();
  }

}