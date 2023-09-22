import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../palette.dart';

class BottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  BottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GNav(
        onTabChange: (value) => onTabChange!(value),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        gap: 10,
        activeColor: Palette.lightGreyColour,
        tabActiveBorder: Border.all(color: Palette.lightGreyColour),
        tabs: const [
          GButton(
            icon: Icons.checklist_outlined,
            iconColor:Palette.lightGreyColour1 ,
            text: "Tasks",
            textColor: Palette.lightGreyColour,
            gap: 10,
          ),
          GButton(
            icon: Icons.notes_outlined,
            text: "Notes",
            textColor: Palette.lightGreyColour,
            iconColor:Palette.lightGreyColour1 ,
            gap: 10,
          ),
        ],
      ),
    );
  }
}
