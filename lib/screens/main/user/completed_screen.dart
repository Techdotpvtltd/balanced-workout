// Project: 	   balanced_workout
// File:    	   completed_screen
// Path:    	   lib/screens/main/user/completed_screen.dart
// Author:       Ali Akbar
// Date:        08-05-24 16:36:24 -- Wednesday
// Description:

import 'package:flutter/material.dart';

import '../../../utils/constants/app_theme.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/extensions/navigation_service.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_container.dart';
import '../../components/custom_paddings.dart';
import 'components/custom_tab_bar.dart';
import 'components/product_card.dart';
import 'courses/progress_course_screen.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  bool isWorkoutSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: 'Completed ${isWorkoutSelected ? 'Workout' : 'Challenges'}'),
      body: CustomPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Tab bar
            CustomTabBar(
              items: const ['Completed Workout', ' Completed Challenges'],
              onPressed: (index) {
                setState(() {
                  isWorkoutSelected = index == 0;
                });
              },
            ),
            gapH36,

            /// Status View
            CustomContainer(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              color: const Color(0xFF1E1E1E),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${isWorkoutSelected ? 'Workout' : 'Challenges'} Completed',
                    style: const TextStyle(
                      color: AppTheme.primaryColor1,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    isWorkoutSelected ? '5' : '13',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            /// Title
            gapH28,
            Text(
              'Completed ${isWorkoutSelected ? 'Workout' : 'Challenges'}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: isWorkoutSelected ? 5 : 13,
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 7, top: 8),
                itemBuilder: (context, index) {
                  return ProductCard(
                    title: "Simply Chest Work",
                    subTitle: "7 weeks",
                    onClickCard: () {
                      NavigationService.go(const ProgressCourseScreen());
                    },
                    coverUrl:
                        'https://allmaxnutrition.com/cdn/shop/articles/13576-1200x600-1.jpg?v=1678816564',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
