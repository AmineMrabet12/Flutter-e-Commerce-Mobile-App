// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, unused_field, missing_required_param, missing_return, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, deprecated_member_use, duplicate_ignore

import 'package:beauty/constants.dart';
import 'package:beauty/screens/product_page.dart';
import 'package:beauty/widgets/custom_action_bar.dart';
import 'package:beauty/widgets/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("products");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              // Collection Data ready to display
              if (snapshot.connectionState == ConnectionState.done) {
                // Display the data inside a list of view
                return ListView(
                    padding: EdgeInsets.only(
                      top: 110,
                      bottom: 12,
                    ),
                    children: snapshot.data.docs.map((document) {
                      return ProductCard(
                        title: document.data()['name'],
                        imageUrl: document.data()['image'][0],
                        price: "\$${document.data()['price']}",
                        productId: document.id,
                      );
                    }).toList());
              }

              // Loading State
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            title: "Home",
            hasBackArrow: false,
          ),
        ],
      ),
    );
  }
}
