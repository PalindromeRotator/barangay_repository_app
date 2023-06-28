// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:barangay_repository_app/firebase_query.dart';
import 'package:barangay_repository_app/widgets/containers/auth/login/login_functions.dart';
import 'package:barangay_repository_app/widgets/containers/auth/register/register.dart';
import 'package:barangay_repository_app/widgets/containers/pages/tabs/main_tab.dart';
import 'package:barangay_repository_app/widgets/core/core_button/core_button.dart';
import 'package:barangay_repository_app/widgets/core/core_textfield/core_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseQuery firebaseQuery = FirebaseQuery();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    firebaseQuery.main();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLoading
                    ? Center(
                        child:
                            CircularProgressIndicator(), // Add CircularProgressIndicator widget here
                      )
                    : Container(),
                Text(
                  'Login your account here',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16,
                ),
                CoreTextfield(
                  labelText: 'Email',
                  controller: emailController,
                ),
                SizedBox(height: 16.0),
                CoreTextfield(
                  labelText: 'Password',
                  controller: passwordController,
                  obscureText: true,
                ),
                SizedBox(height: 16),
                CoreButton(
                  text: 'Login',
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    LoginFunctions loginFunctions = LoginFunctions(
                        emailController.text,
                        passwordController.text,
                        firebaseQuery,
                        context);

                    loginFunctions.loginAcount().then((value) {
                      print(value);
                      setState(() {
                        isLoading = false;
                      });
                      if (value) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MainTab()));
                      }
                    });
                  },
                ),
                TextButton(
                    onPressed: (() => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()))
                        }),
                    child: Text("Don't have an account? Register here"))
              ],
            ),
          )),
    );
  }
}
