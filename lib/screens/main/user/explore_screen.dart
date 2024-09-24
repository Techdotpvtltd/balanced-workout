// Project: 	   balanced_workout
// File:    	   explore_screen
// Path:    	   lib/screens/main/user/explore_screen.dart
// Author:       Ali Akbar
// Date:        08-05-24 19:05:03 -- Wednesday
// Description:

import 'package:flutter/material.dart';

import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/extensions/navigation_service.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_paddings.dart';
import '../../components/custom_scaffold.dart';
import 'article_screen.dart';
import 'community/community_screen.dart';
import 'components/navigation_button.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(
        topPadding: 60,
        title: "Explore",
        showBack: false,
        leftPadding: 29,
        rightPadding: 29,
      ),
      body: CustomPadding(
        child: SizedBox(
          height: 160,
          child: Row(
            children: [
              Expanded(
                child: NavigationButton(
                  icon: AppAssets.backgroundMindedsIcon,
                  title: 'Science and Facts',
                  onPressed: () {
                    NavigationService.go(const ArticleScreen());
                  },
                ),
              ),
              gapW10,
              Expanded(
                child: NavigationButton(
                  icon: AppAssets.backgroundCommunityIcon,
                  title: 'Q&A/Community',
                  onPressed: () {
                    NavigationService.go(const CommunityScreen());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
