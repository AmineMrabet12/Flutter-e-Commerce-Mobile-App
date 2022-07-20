// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_import, avoid_print, unused_element, avoid_unnecessary_containers, deprecated_member_use, unused_field, prefer_final_fields

import 'dart:ffi';

import 'package:beauty/constants.dart';
import 'package:beauty/screens/register_page.dart';
import 'package:beauty/widgets/custom_btn.dart';
import 'package:beauty/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<Void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
            ),
            // ignore: prefer_const_literals_to_create_immutables
            actions: [
              FlatButton(
                child: Text(
                  "Close",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    setState(() {
      _loginFormLoading = true;
    });

    // Run The create Account Method
    String _loginFeedback = await _loginAccount();
    // if the string is not null
    if (_loginFeedback != null) {
      _alertDialogBuilder(_loginFeedback);
      // Set The font to regular state [not Loading]
      setState(() {
        _loginFormLoading = false;
      });
    }
  }

  // Default Form Loading State
  bool _loginFormLoading = false;

  // From Input Field Values
  String _loginEmail = "";
  String _loginPassword = "";

  // Focus Node for input fields
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // ignore: sized_box_for_whitespace
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 24,
                ),
                child: Text(
                  "Welcome!\n Login to your account",
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: "Email...",
                    onChanged: (value) {
                      _loginEmail = value;
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    hintText: "Password...",
                    onChanged: (value) {
                      _loginPassword = value;
                    },
                    focusNode: _passwordFocusNode,
                    isPasswordField: true,
                    onSubmitted: (value) {
                      _submitForm();
                    },
                  ),
                  CustomBtn(
                    text: "Login",
                    onPressed: () {
                      _submitForm();
                    },
                    isLoading: _loginFormLoading,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 14,
                ),
                child: CustomBtn(
                  text: "Create New Account",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  outlineBtn: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
