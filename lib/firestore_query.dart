import 'package:barangay_repository_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class FirestoreQuery {
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
      String email, String password) async {
    int stringThrow = 0;
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        stringThrow = 1;
        await FirebaseAuth.instance.setLanguageCode("en");
        await value.user?.sendEmailVerification();
        await FirebaseAuth.instance.signOut();
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
