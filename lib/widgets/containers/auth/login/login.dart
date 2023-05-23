// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:barangay_repository_app/widgets/containers/auth/register/register.dart';
import 'package:barangay_repository_app/widgets/containers/pages/tabs/main_tab.dart';
import 'package:barangay_repository_app/widgets/core/core_button/core_button.dart';
import 'package:barangay_repository_app/widgets/core/core_textfield/core_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login your account here',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16,
                ),
                CoreTextfield(labelText: 'Email'),
                SizedBox(height: 16.0),
                CoreTextfield(
                  labelText: 'Password',
                  obscureText: true,
                ),
                SizedBox(height: 16),
                CoreButton(
                  text: 'Login',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainTab()));
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
