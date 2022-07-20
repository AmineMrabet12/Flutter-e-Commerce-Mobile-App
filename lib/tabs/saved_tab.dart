// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers

import 'package:beauty/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class SavedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Center(
            child: Text("Saved Tab"),
          ),
          CustomActionBar(
            title: "Saved Products",
            hasBackArrow: false,
          ),
        ],
      ),
    );
  }
}
