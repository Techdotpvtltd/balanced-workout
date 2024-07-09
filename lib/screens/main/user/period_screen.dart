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

import '../../../utils/extensions/navigation_service.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_scaffold.dart';
import 'components/product_card.dart';

class PeriodScreen extends StatelessWidget {
  PeriodScreen({super.key});
  final List<String> periods =
      Period.values.map((e) => e.name.firstCapitalize()).toList();

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
            title: periods[index].firstCapitalize(),
            onClickCard: () {
              final Period period = Period.values.firstWhere(
                  (e) => e.name.toLowerCase() == periods[index].toLowerCase());
              NavigationService.go(
                ActivityLevelScreen(
                  type: ScreenType.courses,
                  selectedPeriod: period,
                ),
              );
            },
            coverUrl:
                'https://images.pexels.com/photos/841130/pexels-photo-841130.jpeg?cs=srgb&dl=pexels-victorfreitas-841130.jpg&fm=jpg',
          );
        },
      ),
    );
  }
}
