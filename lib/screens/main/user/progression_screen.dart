// Project: 	   balanced_workout
// File:    	   progression_screen
// Path:    	   lib/screens/main/user/progression_screen.dart
// Author:       Ali Akbar
// Date:        08-05-24 12:51:57 -- Wednesday
// Description:

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../utils/constants/app_theme.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/extensions/navigation_service.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_paddings.dart';
import '../../components/custom_scaffold.dart';
import 'components/custom_weekly_date.dart';
import 'components/product_card.dart';

class ProgressionScreen extends StatelessWidget {
  const ProgressionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(
        background: const Color(0xFF2C2C2E).withOpacity(0.62),
        title: "Progression",
      ),
      body: Column(
        children: [
          /// Date View
          CustomWeeklyDate(onSelectedDate: (p0) {}),
          Expanded(
            child: SingleChildScrollView(
              child: CustomPadding(
                top: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Pie Chart Views
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /// Workout Pie
                        SizedBox(
                          height: 126,
                          child: PieChart(
                            dataMap: {"App": 34},
                            chartType: ChartType.ring,
                            baseChartColor: AppTheme.darkButtonColor,
                            colorList: [AppTheme.primaryColor1],
                            totalValue: 100,
                            degreeOptions: DegreeOptions(initialAngle: 270),
                            animationDuration: Duration(seconds: 3),
                            chartLegendSpacing: 0,
                            chartValuesOptions: ChartValuesOptions(
                              showChartValueBackground: false,
                              showChartValues: false,
                              showChartValuesInPercentage: false,
                              showChartValuesOutside: false,
                            ),
                            legendOptions: LegendOptions(
                              showLegends: false,
                              showLegendsInRow: false,
                            ),
                            ringStrokeWidth: 8,
                            centerWidget: Text.rich(
                              TextSpan(
                                text: "Workout\n",
                                children: [
                                  TextSpan(
                                    text: "03",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 27,
                                    ),
                                  )
                                ],
                              ),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.26,
                              ),
                            ),
                          ),
                        ),

                        /// Time Pie Chart
                        SizedBox(
                          height: 126,
                          child: PieChart(
                            dataMap: {"App": 70},
                            chartType: ChartType.ring,
                            baseChartColor: AppTheme.darkButtonColor,
                            colorList: [Color(0xFFFF2424)],
                            totalValue: 100,
                            degreeOptions: DegreeOptions(initialAngle: 270),
                            animationDuration: Duration(seconds: 3),
                            chartLegendSpacing: 0,
                            chartValuesOptions: ChartValuesOptions(
                              showChartValueBackground: false,
                              showChartValues: false,
                              showChartValuesInPercentage: false,
                              showChartValuesOutside: false,
                            ),
                            legendOptions: LegendOptions(
                              showLegends: false,
                              showLegendsInRow: false,
                            ),
                            ringStrokeWidth: 8,
                            centerWidget: Text.rich(
                              TextSpan(
                                text: "Time\n",
                                children: [
                                  TextSpan(
                                    text: "45",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 27,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " min",
                                    style: TextStyle(
                                      fontSize: 16.26,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.26,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// Recent Workout Data
                    gapH20,

                    /// Challenge Title
                    const Text(
                      "Recent Work Out",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.52,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    gapH20,

                    /// Challenges List
                    ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 7),
                      itemBuilder: (context, index) {
                        return ProductCard(
                          title: "Simply Chest Work",
                          subTitle: "7x4 Challenge",
                          onClickCard: () {},
                          coverUrl:
                              'https://allmaxnutrition.com/cdn/shop/articles/13576-1200x600-1.jpg?v=1678816564',
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
