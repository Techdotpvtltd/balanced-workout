// Project: 	   balanced_workout
// File:    	   article_detail_screen
// Path:    	   lib/screens/main/user/article_detail_screen.dart
// Author:       Ali Akbar
// Date:        08-05-24 19:31:45 -- Wednesday
// Description:

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_theme.dart';
import '../../../utils/constants/constants.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_network_image.dart';
import '../../components/custom_paddings.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Strength training tips"),
      body: CustomPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Date Label widget
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(AppAssets.clockIcon),
                gapW8,
                const Text(
                  "Published on September 15",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),

            /// Cover Widget
            gapH18,
            SizedBox(
              height: 190,
              width: SCREEN_WIDTH,
              child: const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: CustomNetworkImage(
                  imageUrl:
                      "https://www.mensjournal.com/.image/t_share/MTk2MTM2OTc4OTkxMTYyNTEz/mj-618_348_the-perfect-pull-up.jpg",
                ),
              ),
            ),
            gapH14,
            // Text Widget List
            Expanded(
              child: ListView.builder(
                itemCount: 13,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Title Widget
                        Text(
                          "Plan Your Routine:",
                          style: TextStyle(
                            color: AppTheme.primaryColor1,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        /// Description
                        Text(
                          "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.",
                          style: TextStyle(
                            color: AppTheme.titleColor1,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
