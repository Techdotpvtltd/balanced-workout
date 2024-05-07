// Project: 	   balanced_workout
// File:    	   custom_tab_bar
// Path:    	   lib/screens/main/user/components/custom_tab_bar.dart
// Author:       Ali Akbar
// Date:        07-05-24 19:34:51 -- Tuesday
// Description:

import 'package:flutter/material.dart';

import '../../../../utils/constants/constants.dart';
import '../../../components/custom_container.dart';
import '../../../components/custom_ink_well.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key, required this.items, required this.onPressed});
  final List<String> items;
  final Function(int) onPressed;
  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: SCREEN_WIDTH,
      child: ListView.builder(
        physics: const ScrollPhysics(),
        itemCount: widget.items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final bool isSelected = selectedIndex == index;
          return CustomInkWell(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onPressed(index);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: CustomContainer(
                color: Colors.white.withOpacity(isSelected ? 1 : 0.31),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                borderRadius: const BorderRadius.all(Radius.circular(52)),
                child: Text(
                  widget.items[index],
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
