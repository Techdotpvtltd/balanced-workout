// Project: 	   balanced_workout
// File:    	   active_challenge_screen
// Path:    	   lib/screens/main/user/active_challenge_screen.dart
// Author:       Ali Akbar
// Date:        06-05-24 19:07:23 -- Monday
// Description:

import 'package:flutter/material.dart';

import '../../../utils/extensions/navigation_service.dart';
import '../../components/custom_app_bar.dart';
import 'components/product_card.dart';
import 'playlist_screen.dart';

class ActiveChallengeScreen extends StatelessWidget {
  const ActiveChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Active Workouts",
      ),
      body: ListView.builder(
        physics: const ScrollPhysics(),
        itemCount: 4,
        shrinkWrap: true,
        padding:
            const EdgeInsets.only(bottom: 30, left: 29, right: 29, top: 10),
        itemBuilder: (context, index) {
          return ProductCard(
            title: "Healthy Weight Loss",
            subTitle: "7 Weeks",
            coverUrl:
                'https://img.freepik.com/free-photo/young-happy-sportswoman-getting-ready-workout-tying-shoelace-fitness-center_637285-470.jpg?size=626&ext=jpg&ga=GA1.1.1224184972.1714867200&semt=sph',
            onClickCard: () {
              NavigationService.go(const PlaylistScreen());
            },
          );
        },
      ),
    );
  }
}
