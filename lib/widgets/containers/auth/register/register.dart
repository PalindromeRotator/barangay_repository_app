// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:barangay_repository_app/widgets/containers/auth/login/login.dart';
import 'package:flutter/material.dart';
import 'package:barangay_repository_app/widgets/core/core_button/core_button.dart';
import 'package:barangay_repository_app/widgets/core/core_textfield/core_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Register your account here',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16,
                ),
                CoreTextfield(labelText: 'Full Name'),
                SizedBox(
                  height: 16,
                ),
                CoreTextfield(labelText: 'Email'),
                SizedBox(
                  height: 16,
                ),
                CoreTextfield(labelText: 'Address'),
                SizedBox(
                  height: 16,
                ),
                CoreTextfield(labelText: 'Precint Number'),
                SizedBox(
                  height: 16,
                ),
                CoreTextfield(labelText: 'Length of stay in San Nicolas'),
                SizedBox(height: 16.0),
                CoreTextfield(
                  labelText: 'Password',
                  obscureText: true,
                ),
                SizedBox(
                  height: 16,
                ),
                CoreTextfield(
                  labelText: 'Confirm Password',
                  obscureText: true,
                ),
                SizedBox(height: 16),
                CoreButton(
                  text: 'Register',
                  onPressed: () {},
                ),
                TextButton(
                    onPressed: (() => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()))
                        }),
                    child: Text('Already have an account? Sign-In instead'))
              ],
            )),
          )),
    );
  }
}
