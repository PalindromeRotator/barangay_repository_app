// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:barangay_repository_app/firestore_query.dart';
import 'package:barangay_repository_app/widgets/containers/auth/login/login.dart';
import 'package:barangay_repository_app/widgets/containers/auth/register/register_functions.dart';
import 'package:barangay_repository_app/widgets/containers/auth/register/verification_sent_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:barangay_repository_app/widgets/core/core_button/core_button.dart';
import 'package:barangay_repository_app/widgets/core/core_textfield/core_textfield.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController precintNumberController = TextEditingController();
  TextEditingController lengthOfStayController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FirestoreQuery firestoreQuery = FirestoreQuery();

  @override
  void initState() {
    super.initState();
    firestoreQuery.main();
  }

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    addressController.dispose();
    precintNumberController.dispose();
    lengthOfStayController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

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
                CoreTextfield(
                  labelText: 'Full Name',
                  controller: fullNameController,
                ),
                SizedBox(
                  height: 16,
                ),
                CoreTextfield(
                  labelText: 'Email',
                  controller: emailController,
                ),
                SizedBox(
                  height: 16,
                ),
                CoreTextfield(
                  labelText: 'Address',
                  controller: addressController,
                ),
                SizedBox(
                  height: 16,
                ),
                CoreTextfield(
                  labelText: 'Precint Number',
                  controller: precintNumberController,
                ),
                SizedBox(
                  height: 16,
                ),
                CoreTextfield(
                  labelText: 'Length of stay in San Nicolas',
                  controller: lengthOfStayController,
                ),
                SizedBox(height: 16.0),
                CoreTextfield(
                  labelText: 'Password',
                  obscureText: true,
                  controller: passwordController,
                ),
                SizedBox(
                  height: 16,
                ),
                CoreTextfield(
                  labelText: 'Confirm Password',
                  obscureText: true,
                  controller: confirmPasswordController,
                ),
                SizedBox(height: 16),
                CoreButton(
                    text: 'Register',
                    onPressed: (() {
                      if (passwordController.text != '' &&
                          confirmPasswordController.text != '') {
                        RegisterFunctions registerFunctions = RegisterFunctions(
                            emailController.text,
                            passwordController.text,
                            firestoreQuery,
                            context,
                            VerificationSentPage());

                        registerFunctions.registerAcount();
                      } else {
                        Alert(
                            context: context,
                            type: AlertType.error,
                            desc: "Password and Confirm Password not Matched.",
                            closeFunction: null,
                            closeIcon: null,
                            buttons: [
                              DialogButton(
                                  onPressed: (() => Navigator.pop(context)),
                                  child: const Text('OK'))
                            ]).show();
                      }
                    })),
                TextButton(
                    onPressed: (() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }),
                    child: Text('Already have an account? Sign-In instead'))
              ],
            )),
          )),
    );
  }
}
