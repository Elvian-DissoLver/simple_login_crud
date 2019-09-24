import 'package:flutter/material.dart';

class User {
  final String id;
  final String username;
  final String password;
  DateTime date;

  User({
    @required this.id,
    @required this.username,
    @required this.password,
    @required this.date,
  });
}
