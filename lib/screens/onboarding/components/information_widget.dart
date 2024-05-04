// Project: 	   balanced_workout
// File:    	   information_widget
// Path:    	   lib/screens/onboarding/components/information_widget.dart
// Author:       Ali Akbar
// Date:        04-05-24 15:58:29 -- Saturday
// Description:

import 'package:flutter/material.dart';

import '../../../utils/constants/app_theme.dart';
import '../../../utils/constants/constants.dart';
import '../../components/custom_paddings.dart';
import '../../components/custom_scaffold.dart';
import 'actions_button.dart';

class InformationWidget extends StatefulWidget {
  const InformationWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.showBackButton = true,
    required this.onPressedNext,
    required this.middleWidget,
    this.rightButtonTitle,
  });
  final String title;
  final String subTitle;
  final bool showBackButton;
  final VoidCallback onPressedNext;
  final Widget middleWidget;
  final String? rightButtonTitle;
  @override
  State<InformationWidget> createState() => _InformationWidgetState();
}

class _InformationWidgetState extends State<InformationWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: SizedBox(
          width: SCREEN_WIDTH,
          height: SCREEN_HEIGHT,
          child: CustomPadding(
            top: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      gapH8,
                      Text(
                        widget.subTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppTheme.titleColor3,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: widget.middleWidget,
                        ),
                      ),
                    ],
                  ),
                ),

                // Back Button
                ActionsButton(
                  onPressedNext: widget.onPressedNext,
                  isShowBack: widget.showBackButton,
                  rightButtonTitle: widget.rightButtonTitle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
