import 'package:flutter/material.dart';

class User {
  int id;
  String username;
  String password;
  DateTime date;

  User({
    this.id,
    this.username,
    this.password,
    this.date,
  });

  User.fromMap(Map<String, dynamic> map) {
    this.id = map['_id'];
    this.username = map['username'];
    this.password = map['password'];
    this.date = DateTime.parse(map['date']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': this.id,
      'username': this.username,
      'password': this.password,
      'date': this.date.toIso8601String()
    };
  }
}
