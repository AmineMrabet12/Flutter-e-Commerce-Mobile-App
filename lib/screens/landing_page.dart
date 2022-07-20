// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, use_key_in_widget_constructors, unnecessary_import, unused_import, import_of_legacy_library_into_null_safe, unused_local_variable, unnecessary_null_comparison, unrelated_type_equality_checks

import 'package:beauty/constants.dart';
import 'package:beauty/screens/home_page.dart';
import 'package:beauty/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // if snapshot has error
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }

        // Connection initialized - firebase is running
        if (snapshot.connectionState == ConnectionState.done) {
          /// Stream builder can check the login state live
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
              // if snapshot has error
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${streamSnapshot.error}"),
                  ),
                );
              }

              // Connection state activate - Do the user login check inside the if statement
              if (streamSnapshot.connectionState == ConnectionState.active) {
                // Get the user
                User _user = streamSnapshot.data;

                if (_user == null) {
                  // User not logged in
                  return LoginPage();
                } else {
                  // user logged in --> HomePage
                  return HomePage();
                }
              }

              // checking the auth state - Loading
              return Scaffold(
                body: Center(
                  child: Text(
                    "Checking Authentication...",
                    style: Constants.regularHeading,
                  ),
                ),
              );
            },
          );
        }

        // connection to Firebase - Loading
        return Scaffold(
          body: Center(
            child: Text(
              "Initialization App...",
              style: Constants.regularHeading,
            ),
          ),
        );
      },
    );
  }
}
