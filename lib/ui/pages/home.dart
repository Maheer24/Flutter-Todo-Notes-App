import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:zenlist1/palette.dart';

import '../../widgets/bottom_nav_bar.dart';
import 'notesPage.dart';
import 'to_do_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //navigate bottom bar
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //pages to display
  final List<Widget> _pages = [
    ToDoPage(),
    NotesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.whiteColor,
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavBar(
          onTabChange: (index) => navigateBottomBar(index),
        ),
      ),
    );
  }
}
