import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String email;
  final String fullName;
  final String password;
  final String uniName;
  final String uniID;
  final String username;

  const UserModel({
    this.id,
    required this.email,
    required this.fullName,
    required this.password,
    required this.uniName,
    required this.uniID,
    required this.username,
  });

  toJson() {
    return {"email": email, "full name": fullName, "password": password, "university name": uniName, "university id": uniID, "username": username};
  }

  //map user fetch from firebase to usermodel
  UserModel? _userFromFirebaseSnapshot(DocumentSnapshot? snapshot) {
  if (snapshot == null || !snapshot.exists) {
    return null;
  }

  final data = snapshot.data() as Map<String, dynamic>;

  return UserModel(
    id: snapshot.id,
    email: data['email'] ?? '',
    fullName: data['full name'] ?? '',
    password: data['password'] ?? '',
    uniName: data['university name'] ?? '',
    uniID: data['university id'] ?? '',
    username: data['username'] ?? '',
  );
  } 
}