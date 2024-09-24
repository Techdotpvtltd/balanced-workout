// Project: 	   balanced_workout
// File:    	   subscription_screen
// Path:    	   lib/screens/main/user/settings/subscription_screen.dart
// Author:       Ali Akbar
// Date:        09-05-24 13:10:15 -- Thursday
// Description:

import 'package:flutter/material.dart';

import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_ink_well.dart';
import '../../../components/custom_paddings.dart';
import '../../../components/custom_scaffold.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImagePath: AppAssets.cover1,
      appBar: customAppBar(),
      body: CustomPadding(
        bottom: 82,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            /// Title
            const Text(
              "Be Premium\nGet unlimited access",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Text(
              "When you subscribe, you’ll get instant unlimited access",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            gapH50,
            gapH50,

            /// Plan List
            const _PlanList(),
            gapH50,

            /// Subscribe Now Button
            CustomButton(
              onPressed: () {},
              title: "Subscribe Now",
            )
          ],
        ),
      ),
    );
  }
}

// ===========================Plan List================================
class _PlanList extends StatefulWidget {
  const _PlanList();

  @override
  State<_PlanList> createState() => _PlanListState();
}

class _PlanListState extends State<_PlanList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int index = 0; index < 2; index++)
          Builder(
            builder: (context) {
              bool isSelected = selectedIndex == index;
              return CustomInkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 9),
                  padding: const EdgeInsets.only(
                      left: 25, right: 21, top: 26, bottom: 18),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.primaryColor1.withOpacity(0.16)
                        : const Color(0xFF222221),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.primaryColor1
                          : Colors.transparent,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Round Widget
                      Row(
                        children: [
                          Container(
                            width: 23,
                            height: 23,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppTheme.primaryColor1,
                                width: isSelected ? 5 : 1,
                              ),
                            ),
                          ),
                          gapW18,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Monthly",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              gapH4,
                              Text(
                                "Pay monthly, cancel any time",
                                style: TextStyle(
                                  color: isSelected
                                      ? AppTheme.primaryColor1
                                      : Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      /// Price Label
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\$",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: "18",
                              children: [
                                TextSpan(
                                  text: "/m",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
