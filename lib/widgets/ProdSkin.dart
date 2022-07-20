// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_final_fields, unused_field

import 'package:flutter/material.dart';

class ProductSkin extends StatefulWidget {
  @override
  State<ProductSkin> createState() => _ProductSkinState();
}

class _ProductSkinState extends State<ProductSkin> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
      ),
      height: 35,
      child: Row(
        children: [
          Image.asset("assets/images/Picture1.png"),
          Image.asset("assets/images/Picture2.png"),
          Image.asset("assets/images/Picture3.png"),
          Image.asset("assets/images/Picture4.png"),
          Image.asset("assets/images/Picture5.png"),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
