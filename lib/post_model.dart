import 'pages_student/post.dart';
import 'package:flutter/material.dart';

class PostModel {
  final String id;
  final String house;
  final String address;
  final String amount;
  final String money;
  final String phoneno;
  final String usercaller;
  final String user;

  PostModel({
    required this.id,
    required this.house,
    required this.address,
    required this.amount,
    required this.money,
    required this.phoneno,
    required this.usercaller,
    required this.user,
  });
}