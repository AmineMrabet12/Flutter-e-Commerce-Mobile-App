// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use, unused_import, avoid_unnecessary_containers, avoid_types_as_parameter_names, prefer_final_fields, unused_field, avoid_print

import 'package:beauty/constants.dart';
import 'package:beauty/services/firebase_services.dart';
import 'package:beauty/tabs/home_tab.dart';
import 'package:beauty/tabs/saved_tab.dart';
import 'package:beauty/tabs/search_tab.dart';
import 'package:beauty/widgets/bottom_tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  PageController _tabsPageController;
  int _selectedTab;

  @override
  void initState() {
    print("UserID: ${_firebaseServices.getUserId()}");
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              controller: _tabsPageController,
              onPageChanged: (num) {
                setState(() {
                  _selectedTab = num;
                });
              },
              children: [
                HomeTab(),
                SearchTab(),
                SavedTab(),
              ],
            ),
          ),
          BottomTabs(
            selectdTab: _selectedTab,
            tabPressed: (num) {
              _tabsPageController.animateToPage(num,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic);
            },
          ),
        ],
      ),
    );
  }
}
