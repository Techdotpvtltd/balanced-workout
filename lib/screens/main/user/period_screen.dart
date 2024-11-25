// Project: 	   balanced_workout
// File:    	   period_screen
// Path:    	   lib/screens/main/user/period_screen.dart
// Author:       Ali Akbar
// Date:        06-05-24 20:02:40 -- Monday
// Description:

import 'package:balanced_workout/screens/main/user/activity_level_screen.dart';
import 'package:balanced_workout/utils/constants/enum.dart';
import 'package:balanced_workout/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/app_assets.dart';
import '../../../utils/extensions/navigation_service.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_scaffold.dart';
import 'components/product_card.dart';

class PeriodScreen extends StatelessWidget {
  PeriodScreen({super.key});
  final List<Period> periods = Period.values;

  final List<String> images = [
    AppAssets.weekly,
    AppAssets.monthly,
    AppAssets.quarter,
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(
        title: "Period",
      ),
      body: ListView.builder(
        itemCount: periods.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        padding:
            const EdgeInsets.only(bottom: 30, left: 29, right: 29, top: 20),
        itemBuilder: (context, index) {
          return ProductCard(
            title: periods[index].name.firstCapitalize(),
            isAsset: true,
            onClickCard: () {
              NavigationService.go(
                ActivityLevelScreen(
                  type: ScreenType.courses,
                  selectedPeriod: periods[index],
                ),
              );
            },
            coverUrl: images[index],
          );
        },
      ),
    );
  }
}
