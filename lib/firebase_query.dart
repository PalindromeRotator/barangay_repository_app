import 'package:barangay_repository_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class FirebaseQuery {
  // FirebaseFirestore firestoreDB = FirebaseFirestore.instance;
  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(const MyApp());
  }

  bool authStateChanges() {
    bool flag = false;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        flag = false;
      } else {
        flag = true;
      }
    });
    return flag;
  }

  bool idTokenChanges() {
    bool flag = false;
    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      if (user == null) {
        flag = false;
      } else {
        flag = true;
      }
    });

    return flag;
  }

  bool userChanges() {
    bool flag = false;
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        flag = false;
      } else {
        flag = true;
      }
    });
    return flag;
  }

  Future<int> createUserWithEmailAndPassword(
      String email, String password, String fullName) async {
    int stringThrow = 0;
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        await value.user?.updateDisplayName(fullName);
        stringThrow = 1;
        await FirebaseAuth.instance.setLanguageCode("en");
        await value.user?.sendEmailVerification();
        if (kDebugMode) {
          print(value.user);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        stringThrow = 2;
      } else if (e.code == 'email-already-in-use') {
        stringThrow = 3;
      }
    } catch (e) {
      stringThrow = 4;
      print(e);
    }

    return stringThrow;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    User? userReturn;
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then(((value) {
        print(value.user);
        userReturn = value.user;
      }));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return userReturn;
  }

  Future<void> updateProfile(String name, String lengthOfStay,
      String precintNumber, String address, User? user) async {
    await user?.updateDisplayName(name);
    await updateUserOtherCredentials(
        name, lengthOfStay, precintNumber, address, user!.uid.toString());
  }

  //---------------------------- FIRESTORE QUERIES ------------------------------------//

  Future<Map<String, dynamic>> getUserCredentials(String documentId) async {
    FirebaseFirestore firestoreDB = FirebaseFirestore.instance;
    final docRef = firestoreDB.collection("users").doc(documentId);
    var snapshot = await docRef.get();
    return snapshot.data() as Map<String, dynamic>;
    // ...
  }

  Future<bool> setUserCredentials(
    String precint_number,
    String length_of_stay,
    String address,
    String fullName,
    String? docId,
  ) async {
    FirebaseFirestore firestoreDB = FirebaseFirestore.instance;
    bool returnFlag = false;
    DateTime currentTime = DateTime.now();
    // int epochTime = currentTime.millisecondsSinceEpoch;
    final credentials = <String, dynamic>{
      "completeName": fullName,
      "precintNumber": precint_number,
      "lengthOfStay": length_of_stay,
      "completeAddress": address,
      "createdAt": currentTime,
    };
    firestoreDB
        .collection("users")
        .doc(docId)
        .set(credentials)
        .then((value) => returnFlag = true)
        .catchError((error) => print('error: $error'));
    return returnFlag;
  }

  Future<void> updateUserOtherCredentials(String name, String lengthOfStay,
      String precintNumber, String address, String documentId) async {
    FirebaseFirestore firestoreDB = FirebaseFirestore.instance;
    DateTime currentTime = DateTime.now();
    final users = <String, dynamic>{
      "completeAddress": address,
      "completeName": name,
      "lengthOfStay": lengthOfStay,
      "precintNumber": precintNumber,
      "updatedAt": currentTime
    };

    firestoreDB
        .collection("users")
        .doc(documentId)
        .set(users)
        .onError((e, _) => print("Error writing document: $e"));
  }

  Future<void> logout(FirebaseAuth auth, Function(void) thenPress) async {
    try {
      await auth.signOut().then(
            thenPress,
          );
      // Optionally, perform any additional actions after signing out
    } catch (e) {
      print('Logout failed: $e');
      // Handle any errors that occur during logout
    }
  }
}
