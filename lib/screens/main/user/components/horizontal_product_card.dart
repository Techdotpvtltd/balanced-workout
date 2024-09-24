// Project: 	   balanced_workout
// File:    	   horizontal_product_card
// Path:    	   lib/screens/main/user/components/horizontal_product_card.dart
// Author:       Ali Akbar
// Date:        06-05-24 18:24:58 -- Monday
// Description:

import 'package:flutter/material.dart';

import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../components/custom_ink_well.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/custom_paddings.dart';

class HorizontalProductCard extends StatelessWidget {
  const HorizontalProductCard(
      {super.key, required this.coverUrl, required this.title, this.onClick});
  final String coverUrl;
  final String title;

  final VoidCallback? onClick;
  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onClick,
      child: Container(
        width: SCREEN_WIDTH * 0.5,
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
                  width: SCREEN_WIDTH,
                  height: constraints.maxHeight * 0.8,
                ),
                gapH6,

                /// Title
                HorizontalPadding(
                  value: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
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
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
