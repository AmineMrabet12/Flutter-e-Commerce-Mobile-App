// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, sized_box_for_whitespace, prefer_const_constructors, missing_required_param, avoid_types_as_parameter_names

import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {
  final List imageList;
  ImageSwipe({this.imageList});

  @override
  State<ImageSwipe> createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: Stack(
          children: [
            PageView(
              onPageChanged: (num) {
                setState(() {
                  _selectedPage = num;
                });
              },
              children: [
                for (var i = 0; i < widget.imageList.length; i++)
                  Container(
                      child: Image.network(
                    "${widget.imageList[i]}",
                    fit: BoxFit.cover,
                  ))
              ],
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < widget.imageList.length; i++)
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOutCirc,
                      margin: EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      width: _selectedPage == i ? 35 : 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12)),
                    )
                ],
              ),
            )
          ],
        ));
  }
}
