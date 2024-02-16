import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;

  FirebaseAuthMethods(this._auth);

  // Get the current user
  User get user => _auth.currentUser!;

  // Stream to listen for authentication state changes
  Stream<User?> get authState => _auth.authStateChanges();

  // Method to handle user registration
  Future<void> signInWithEmailAndPassword(
      String email, String password, String name, BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      // Add user details to Firestore after registration
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(_auth.currentUser?.uid)
          .set({"email": email, "name": name});
    } on FirebaseAuthException catch (e) {
      Utils.snackBar(e.message!, context);
    }
  }

  // Method to handle user login
  Future<void> loginWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Utils.snackBar(e.message!, context);
    }
  }

  // Method to handle user sign out
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      Utils.snackBar(e.message!, context);
    }
  }
}
