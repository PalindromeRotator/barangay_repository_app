import 'package:barangay_repository_app/firestore_query.dart';
import 'package:barangay_repository_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterFunctions {
  String? _email;
  String? _password;
  FirestoreQuery? _firestoreQuery;
  BuildContext? _context;
  Widget? _navigator;

  RegisterFunctions(String email, String password,
      FirestoreQuery firestoreQuery, BuildContext context, Widget navigator) {
    _email = email;
    _password = password;
    _firestoreQuery = firestoreQuery;
    _context = context;
    _navigator = navigator;
  }
  void registerAcount() {
    _firestoreQuery!
        .createUserWithEmailAndPassword(_email!, _password!)
        .then((value) {
      switch (value) {
        case 0:
          {
            Alert(
                context: _context!,
                type: AlertType.error,
                desc: "Invalid email format.",
                closeFunction: null,
                buttons: [
                  DialogButton(
                      onPressed: (() => Navigator.pop(_context!)),
                      child: const Text('OK'))
                ]).show();
            break;
          }
        case 1:
          {
            Alert(
                context: _context!,
                type: AlertType.success,
                desc: "Successfully registered.",
                closeFunction: null,
                closeIcon: null,
                buttons: [
                  DialogButton(
                      onPressed: (() => Navigator.pop(_context!)),
                      child: const Text('OK'))
                ]).show().then((value) => Navigator.push(_context!,
                MaterialPageRoute(builder: (context) => _navigator!)));
            break;
          }
        case 2:
          {
            Alert(
                context: _context!,
                type: AlertType.error,
                desc: "Password is weak.",
                closeFunction: null,
                buttons: [
                  DialogButton(
                      onPressed: (() => Navigator.pop(_context!)),
                      child: const Text('OK'))
                ]).show();
            break;
          }
        case 3:
          {
            Alert(
                context: _context!,
                type: AlertType.error,
                desc: "Email ${_email} is already in use.",
                closeFunction: null,
                buttons: [
                  DialogButton(
                      onPressed: (() => Navigator.pop(_context!)),
                      child: const Text('OK'))
                ]).show();
            break;
          }
        default:
          {
            Alert(
                context: _context!,
                type: AlertType.error,
                desc: "Something went wrong.....",
                closeFunction: null,
                buttons: [
                  DialogButton(
                      onPressed: (() => Navigator.pop(_context!)),
                      child: const Text('OK'))
                ]).show();
          }
      }
    });
  }
}
