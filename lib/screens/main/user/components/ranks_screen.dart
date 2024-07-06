// Project: 	   balanced_workout
// File:    	   ranks_screen
// Path:    	   lib/screens/main/user/ranks_screen.dart
// Author:       Ali Akbar
// Date:        06-05-24 20:02:40 -- Monday
// Description:

import 'package:flutter/material.dart';

import '../../../components/custom_app_bar.dart';
import '../../../components/custom_scaffold.dart';

import 'product_card.dart';

class RankScreen extends StatelessWidget {
  RankScreen({super.key});
  final List<String> items = [
    "Muscle group",
    "Movement patterns",
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(
        title: "Ranks",
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
              // NavigationService.go(ActivityLevelScreen());
            },
            coverUrl:
                'https://img.freepik.com/free-photo/young-happy-sportswoman-getting-ready-workout-tying-shoelace-fitness-center_637285-470.jpg?size=626&ext=jpg&ga=GA1.1.1224184972.1714867200&semt=sph',
          );
        },
      ),
    );
  }
}
