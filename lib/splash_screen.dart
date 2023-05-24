// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api

import 'dart:async';
import 'package:barangay_repository_app/firestore_query.dart';
import 'package:barangay_repository_app/widgets/containers/auth/login/login.dart';
import 'package:barangay_repository_app/widgets/containers/pages/tabs/main_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LocalStorage storage = new LocalStorage('some_key');
  FirestoreQuery firestoreQuery = new FirestoreQuery();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    firestoreQuery.main();
    // Simulating a delay for demonstration purposes
    print(_auth.currentUser?.emailVerified);
    Timer(Duration(seconds: 3), () {
      // Replace this with your actual app's home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                _auth.currentUser == null ? LoginPage() : MainTab()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Customize the background color if needed
      body: Center(
        child: Image.asset(
          'assets/images/splash_image.png', // Replace with your image path
          width: 200,
          height: 200,
          // Customize the image width and height as per your requirement
        ),
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LoginPage(),
//     );
//   }
// }
