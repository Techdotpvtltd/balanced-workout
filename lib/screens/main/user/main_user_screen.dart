// Project: 	   balanced_workout
// File:    	   main_user_screen
// Path:    	   lib/screens/main/user/main_user_screen.dart
// Author:       Ali Akbar
// Date:        06-05-24 11:29:16 -- Monday
// Description:

import 'package:balanced_workout/screens/main/user/my_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_theme.dart';
import '../../../utils/constants/constants.dart';
import '../../components/custom_ink_well.dart';
import 'explore_screen.dart';
import 'home_screen.dart';
import 'setting_screen.dart';
import 'workout_screen.dart';

final List<String> icons = [
  AppAssets.homeIcon,
  AppAssets.dumbbellIcon,
  AppAssets.profileIcon,
  AppAssets.compassIcon,
  AppAssets.gearIcon,
];

final List<String> selectedIcons = [
  AppAssets.selectedHomeIcon,
  AppAssets.selectedDumbbellIcon,
  AppAssets.profileIcon,
  AppAssets.selectedCompassIcon,
  AppAssets.selectedGearIcon,
];

final List<Widget> screens = [
  const HomeScreen(),
  const WorkoutScreen(),
  const MyScreen(),
  const ExploreScreen(),
  const SettingScreen(),
];

class MainUserScreen extends StatefulWidget {
  const MainUserScreen({super.key});

  @override
  State<MainUserScreen> createState() => _MainUserScreenState();
}

class _MainUserScreenState extends State<MainUserScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: icons.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(
        barColor: const Color(0xFF3A3A3C),
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        width: SCREEN_WIDTH * 0.8,
        fit: StackFit.loose,
        barDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        barAlignment: Alignment.bottomCenter,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            TabBar(
              controller: tabController,
              padding: const EdgeInsets.symmetric(vertical: 5),
              indicatorColor: Colors.transparent,
              tabAlignment: TabAlignment.fill,
              dividerColor: Colors.transparent,
              tabs: [
                for (int index = 0; index < icons.length; index++)
                  index == 2
                      ? const SizedBox()
                      : CustomInkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            height: 52,
                            width: 52,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selectedIndex == index
                                  ? AppTheme.primaryColor1
                                  : const Color(0xFF4A4A4A),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                selectedIndex == index
                                    ? selectedIcons[index]
                                    : icons[index],
                              ),
                            ),
                          ),
                        ),
              ],
            ),
            Positioned(
              top: -23,
              child: CustomInkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                },
                child: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedIndex == 2
                        ? AppTheme.primaryColor1
                        : const Color(0xFF1E1E1E),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppAssets.profileIcon,
                      colorFilter: ColorFilter.mode(
                          selectedIndex == 2
                              ? Colors.black
                              : const Color(0xFFB6B6B6),
                          BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: (context, controller) => screens[selectedIndex],
      ),
    );
  }
}
