// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_final_fields, unused_field, must_be_immutable

import 'package:beauty/constants.dart';
import 'package:beauty/screens/cart_page.dart';
import 'package:beauty/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasBackground;
  CustomActionBar(
      {this.title, this.hasBackArrow, this.hasTitle, this.hasBackground});

  FirebaseServices _firebaseServices = FirebaseServices();

  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasBackground = hasBackground ?? true;

    return Container(
      decoration: BoxDecoration(
          gradient: _hasBackground
              ? LinearGradient(
                  // ignore: prefer_const_literals_to_create_immutables
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0),
                  ],
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1),
                )
              : null),
      padding: EdgeInsets.only(
        top: 56,
        left: 24,
        right: 24,
        bottom: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12)),
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage("assets/images/back_arrow.png"),
                  color: Colors.white,
                ),
              ),
            ),
          if (_hasTitle)
            Text(
              title ?? "Action Bar",
              style: Constants.boldHeading,
            ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
            },
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(12)),
              alignment: Alignment.center,
              child: StreamBuilder(
                stream: _userRef
                    .doc(_firebaseServices.getUserId())
                    .collection("Cart")
                    .snapshots(),
                builder: (context, snapshot) {
                  int _totalItem = 0;

                  if (snapshot.connectionState == ConnectionState.active) {
                    List _document = snapshot.data.docs;
                    _totalItem = _document.length;
                  }

                  return Text(
                    "$_totalItem" ?? "0",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
