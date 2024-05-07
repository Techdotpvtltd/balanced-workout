// Project: 	   balanced_workout
// File:    	   horizontal_product_card
// Path:    	   lib/screens/main/user/components/horizontal_product_card.dart
// Author:       Ali Akbar
// Date:        06-05-24 18:24:58 -- Monday
// Description:

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/custom_paddings.dart';

class HorizontalProductCard extends StatelessWidget {
  const HorizontalProductCard(
      {super.key,
      required this.coverUrl,
      required this.title,
      required this.timePeriod,
      required this.celeries,
      this.onClick});
  final String coverUrl;
  final String title;
  final String timePeriod;
  final String celeries;
  final VoidCallback? onClick;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: AppTheme.darkWidgetColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Cover View
              CustomNetworkImage(
                imageUrl: coverUrl,
                width: SCREEN_WIDTH * 0.44,
                height: constraints.maxHeight * 0.7,
              ),
              gapH6,

              /// Title
              HorizontalPadding(
                value: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: SCREEN_WIDTH * 0.40,
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    gapH4,
                    Row(
                      children: [
                        SvgPicture.asset(AppAssets.clockIcon),
                        gapW6,
                        Text(
                          timePeriod,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF8C8C8C),
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        gapW12,
                        SvgPicture.asset(AppAssets.fireIcon),
                        gapW6,
                        Text(
                          celeries,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF8C8C8C),
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
