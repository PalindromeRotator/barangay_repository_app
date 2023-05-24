import 'package:barangay_repository_app/firestore_query.dart';
import 'package:barangay_repository_app/main.dart';
import 'package:barangay_repository_app/widgets/containers/auth/register/verification_sent_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginFunctions {
  String? _email;
  String? _password;
  FirestoreQuery? _firestoreQuery;
  BuildContext? _context;
  Widget? _navigator;
  FirebaseAuth? _auth;

  LoginFunctions(String email, String password, FirestoreQuery firestoreQuery,
      BuildContext context, Widget navigator) {
    _email = email;
    _password = password;
    _firestoreQuery = firestoreQuery;
    _context = context;
    _navigator = navigator;
  }

  void loginAcount() {
    _firestoreQuery!
        .signInWithEmailAndPassword(_email!, _password!)
        .then((value) {
      if (value == null) {
        Alert(
            context: _context!,
            type: AlertType.error,
            desc: "Email or Password is incorrect.",
            closeFunction: null,
            buttons: [
              DialogButton(
                  onPressed: (() => Navigator.pop(_context!)),
                  child: const Text('OK'))
            ]).show();
      } else {
        if (value.emailVerified) {
          Navigator.push(
              _context!, MaterialPageRoute(builder: (context) => _navigator!));
        } else {
          FirebaseAuth.instance.signOut();
          Navigator.push(
              _context!,
              MaterialPageRoute(
                  builder: (context) => const VerificationSentPage()));
        }

        // Alert(
        //     context: _context!,
        //     type: AlertType.success,
        //     desc: "Successfully Login.",
        //     closeFunction: null,
        //     buttons: [
        //       DialogButton(
        //           onPressed: (() => Navigator.pop(_context!)),
        //           child: const Text('OK'))
        //     ]).show().then((value) {
        //   Navigator.push(
        //       _context!, MaterialPageRoute(builder: (context) => _navigator!));
        // });
      }
    });
  }
}
