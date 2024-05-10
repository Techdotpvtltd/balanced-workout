// Project: 	   balanced_workout
// File:    	   article_items
// Path:    	   lib/screens/main/user/components/article_items.dart
// Author:       Ali Akbar
// Date:        10-05-24 12:04:12 -- Friday
// Description:

import 'package:flutter/material.dart';

import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/extensions/navigation_service.dart';
import '../../../components/custom_container.dart';
import '../../../components/custom_network_image.dart';
import '../article_detail_screen.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: CustomContainer(
        onPressed: () {
          NavigationService.go(const ArticleDetailScreen());
        },
        padding: const EdgeInsets.only(left: 12, right: 13, top: 7, bottom: 7),
        color: AppTheme.darkWidgetColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: const Row(
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
                mainAxisAlignment: MainAxisAlignment.center,
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
  }
}
