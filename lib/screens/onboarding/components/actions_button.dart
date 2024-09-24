// Project: 	   balanced_workout
// File:    	   actions_button
// Path:    	   lib/screens/onboarding/components/actions_button.dart
// Author:       Ali Akbar
// Date:        04-05-24 15:41:34 -- Saturday
// Description:

import 'package:flutter/material.dart';

import '../../../utils/constants/app_theme.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/extensions/navigation_service.dart';
import '../../components/custom_ink_well.dart';

class ActionsButton extends StatelessWidget {
  const ActionsButton(
      {super.key,
      required this.onPressedNext,
      this.isShowBack = true,
      this.isLoading = false,
      this.rightButtonTitle});
  final VoidCallback onPressedNext;
  final bool isShowBack;
  final bool isLoading;
  final String? rightButtonTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: isShowBack,
          child: CustomInkWell(
            onTap: () {
              NavigationService.back();
            },
            child: Container(
              width: 140,
              height: 59,
              decoration: const BoxDecoration(
                color: Color(0xFF3A3A3C),
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  gapW8,
                  Text(
                    "Back",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        /// forward
        CustomInkWell(
          onTap: isLoading ? null : onPressedNext,
          child: Container(
            width: 140,
            height: 59,
            decoration: const BoxDecoration(
              color: AppTheme.primaryColor1,
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        rightButtonTitle ?? "Next",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      gapW8,
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
