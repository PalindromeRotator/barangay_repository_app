import 'package:barangay_repository_app/firestore_query.dart';
import 'package:barangay_repository_app/widgets/containers/auth/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirestoreQuery firestoreQuery = FirestoreQuery();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Hello ${_auth.currentUser?.email}'),
                ElevatedButton(
                    onPressed: () => firestoreQuery.logout(_auth, (value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        }),
                    child: const Text('Logout'))
              ])),
    );
  }
}
