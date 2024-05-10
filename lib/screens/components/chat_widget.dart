// Project: 	   balanced_workout
// File:    	   chat_widget
// Path:    	   lib/screens/components/chat_widget.dart
// Author:       Ali Akbar
// Date:        10-05-24 13:46:20 -- Friday
// Description:

import 'package:flutter/material.dart';

import '../../utils/constants/app_theme.dart';
import '../../utils/constants/constants.dart';
import 'avatar_widget.dart';
import 'custom_container.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.only(left: 14, right: 11, top: 12, bottom: 20),
      color: const Color(0xFF2B2B2B).withOpacity(0.68),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /// Time Label
          Text(
            "01:12 PM",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 9,
              color: AppTheme.primaryColor1,
            ),
          ),
          gapH4,
          // Profile
          Row(
            children: [
              AvatarWidget(
                width: 33,
                height: 33,
                backgroundColor: Colors.black,
                placeholderChar: 'T',
              ),
              gapW10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Name Label
                    Text(
                      "Hammad_Habib",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),

                    gapH4,

                    /// Name Label
                    Text(
                      "Faisal: Lorem Ipsum is simply dummy text of the printing and.",
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 9,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
