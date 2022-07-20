// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, unnecessary_string_interpolations, prefer_const_constructors, sized_box_for_whitespace, deprecated_member_use

import 'package:beauty/constants.dart';
import 'package:beauty/screens/product_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;

  ProductCard(
      {Key key,
      this.onPressed,
      this.imageUrl,
      this.title,
      this.price,
      this.productId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(
                productId: productId,
              ),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        height: 350.0,
        margin: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        child: Stack(
          children: [
            Container(
              height: 350,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    "$imageUrl",
                    fit: BoxFit.cover,
                  )),
            ),
            Positioned(
              bottom: 0,
              left: 10,
              right: 10,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: Constants.regularHeading,
                    ),
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
