import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future GetCurrentUser() async {
  final _auth = FirebaseAuth.instance;
  try {
    User user = await _auth.currentUser;
    print('Email' + user.email);
    print('Uid ' + user.uid);

    if (user != Null) {
      return user;
    }
  } catch (e) {
    print(e);
  }
}