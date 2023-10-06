import 'user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  UserModel _userFromFirebaseSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    return UserModel(
      id: snapshot.id,
      email: data?['email'] ?? '',
      fullName: data?['full name'] ?? '',
      password: data?['password'] ?? '',
      uniName: data?['university name'] ?? '',
      uniID: data?['university id'] ?? '',
      username: data?['username'] ?? '',
    );
  }

  Stream<UserModel> getUserInfo(uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .snapshots()
        .map(_userFromFirebaseSnapshot);
  }
}
