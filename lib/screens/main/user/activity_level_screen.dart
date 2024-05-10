// Project: 	   balanced_workout
// File:    	   activity_level_screen
// Path:    	   lib/screens/main/user/activity_level_screen.dart
// Author:       Ali Akbar
// Date:        06-05-24 20:02:40 -- Monday
// Description:

import 'package:flutter/material.dart';

import '../../../utils/extensions/navigation_service.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_scaffold.dart';
import 'components/product_card.dart';
import 'playlist_screen.dart';

class ActivityLevelScreen extends StatelessWidget {
  ActivityLevelScreen({super.key});
  final List<String> items = [
    "Beginner",
    "Intermediate",
    "Advance",
  ];
  final images = [
    'https://propakistani.pk/how-to/wp-content/uploads/2020/07/sxsasd.jpg',
    'https://hips.hearstapps.com/hmg-prod/images/701/rowing-workouts-burn-fat-build-muscle-main-1518562362.jpg?crop=1xw:0.786xh;center,top&resize=640:*',
    'https://www.mensjournal.com/.image/t_share/MTk2MTM3Mjk2NTQ5NTIwNTI5/_main_liftlift.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(
        title: "Activity Level",
      ),
      body: ListView.builder(
        itemCount: items.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        padding:
            const EdgeInsets.only(bottom: 30, left: 29, right: 29, top: 20),
        itemBuilder: (context, index) {
          return ProductCard(
            title: items[index],
            onClickCard: () {
              NavigationService.go(const PlaylistScreen());
            },
            coverUrl: images[index],
          );
        },
      ),
    );
  }
}
