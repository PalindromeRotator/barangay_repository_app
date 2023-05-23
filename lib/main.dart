import 'package:barangay_repository_app/firestore_query.dart';
import 'package:barangay_repository_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

FirestoreQuery firestoreQuery = FirestoreQuery();
void main() {
  firestoreQuery.main();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
