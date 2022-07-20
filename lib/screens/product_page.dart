// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, prefer_const_constructors, deprecated_member_use, sized_box_for_whitespace, unused_local_variable, unused_import, prefer_final_fields, avoid_print

import 'package:beauty/constants.dart';
import 'package:beauty/services/firebase_services.dart';
import 'package:beauty/widgets/custom_action_bar.dart';
import 'package:beauty/widgets/image_swipe.dart';
import 'package:beauty/widgets/ProdSkin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  ProductPage({this.productId});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  Future _addToChart() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"Color Skin": "Null"});
  }

  final SnackBar _snackBar = SnackBar(
    content: Text("Product added to the chart Successfully !"),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.productsRef.doc(widget.productId).get(),
            builder: (context, snapshot) {
              // Error Check
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              // Firebase document data map
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> documentData = snapshot.data.data();

                // List of images
                List imageList = documentData['image'];
                List productSkin = documentData['skin'];

                return ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    ImageSwipe(
                      imageList: imageList,
                    ),
                    // Prod Name PAD
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                        left: 24,
                        right: 24,
                        bottom: 4,
                      ),
                      child: Text(
                        "${documentData['name']}" ?? "Product Name",
                        style: Constants.boldHeading,
                      ),
                    ),
                    // Price PAD
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 24,
                      ),
                      child: Text(
                        "\$${documentData['price']}" ?? "Price",
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // Desc PAD
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 24,
                      ),
                      child: Text(
                        "${documentData['desc']}" ?? "Description",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    // Skin Color PAD
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        right: 24,
                        left: 24,
                        bottom: 5,
                      ),
                      child: Text(
                        "Select Skin Color",
                        style: Constants.regularDarkText2,
                      ),
                    ),
                    ProductSkin(),
                    // 2 Btn PAD (save/add to chart)
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        children: [
                          Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                                color: Color(0xFFDCDCDC),
                                borderRadius: BorderRadius.circular(100)),
                            alignment: Alignment.center,
                            child: Image(
                              image: AssetImage("assets/images/save.png"),
                              width: 60,
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                await _addToChart();
                                Scaffold.of(context).showSnackBar(_snackBar);
                              },
                              child: Container(
                                height: 65,
                                margin: EdgeInsets.only(
                                  left: 16,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(100)),
                                alignment: Alignment.center,
                                child: Text(
                                  "Add To Chart",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
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
            hasBackArrow: true,
            hasTitle: false,
            hasBackground: false,
          )
        ],
      ),
    );
  }
}
