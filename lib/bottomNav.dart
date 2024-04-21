import 'package:flutter/material.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:medicine_reminder/addMeds.dart';
import 'package:medicine_reminder/homeppage.dart';
import 'package:medicine_reminder/medsHistory.dart';

import 'UserProfile/profile.dart';
class BottomNavBar extends StatefulWidget {

  final String keys;
  BottomNavBar({required this.keys});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  late List<Widget> class_Name;

   @override
  void initState() {
    super.initState();
    // Initialize class_Name after accessing widget.keys
    class_Name = [
      HomePage(keys: widget.keys),
      AddMedsPage(keys: widget.keys),
      MedsHistory(),
      Profile(keys: widget.keys)
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: class_Name[selectedIndex]),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color.fromARGB(0, 255, 86, 86).withOpacity(0),
        color: Color.fromRGBO(62,177,110, 1),
        buttonBackgroundColor: Color.fromARGB(255, 0, 0, 0),
        height: 50,
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.easeIn,
        index: selectedIndex,
        
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.dashboard, size: 20, color: Colors.white),
         
          ),
          CurvedNavigationBarItem(
          child: Icon(
            Icons.add,
            size: 20,
            color: Colors.white,
          ),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.history, size: 20, color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.person, size: 20, color: Colors.white),
          ),    
        
         
        ],
        onTap: (index) {
          selectedIndex = index;
          setState(() {
            //change the body

          });
        },
      ),
    );
  }
}