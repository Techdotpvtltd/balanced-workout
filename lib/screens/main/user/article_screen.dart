// Project: 	   balanced_workout
// File:    	   article_screen
// Path:    	   lib/screens/main/user/article_screen.dart
// Author:       Ali Akbar
// Date:        08-05-24 19:15:07 -- Wednesday
// Description:

import 'package:flutter/material.dart';

import '../../../utils/constants/app_theme.dart';
import '../../../utils/constants/constants.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_container.dart';
import '../../components/custom_network_image.dart';
import '../../components/custom_scaffold.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(title: "Science and Facts"),
      body: ListView.builder(
        itemCount: 5,
        padding:
            const EdgeInsets.only(left: 29, right: 29, top: 18, bottom: 14),
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: CustomContainer(
              padding: EdgeInsets.only(left: 12, right: 13, top: 7, bottom: 7),
              color: AppTheme.darkWidgetColor,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Row(
                children: [
                  /// Cover Widget
                  SizedBox(
                    height: 128,
                    width: 148,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: CustomNetworkImage(
                        imageUrl:
                            "https://hips.hearstapps.com/hmg-prod/images/strength-and-power-royalty-free-image-1604353154.?crop=1xw:0.84415xh;center,top",
                      ),
                    ),
                  ),

                  /// Title Widgets
                  gapW10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Strength training",
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        gapH6,
                        Text(
                          "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface.",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          style: TextStyle(
                            color: AppTheme.titleColor2,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
