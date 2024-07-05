// Project: 	   balanced_workout
// File:    	   product_card
// Path:    	   lib/screens/main/user/components/product_card.dart
// Author:       Ali Akbar
// Date:        06-05-24 14:53:15 -- Monday
// Description:

import 'package:flutter/material.dart';

import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_ink_well.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/custom_paddings.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    this.onClickCard,
    this.onClickStartButton,
    required this.title,
    this.subTitle,
    required this.coverUrl,
    this.isAsset = false,
  });
  final VoidCallback? onClickCard;
  final VoidCallback? onClickStartButton;
  final String title;
  final String? subTitle;
  final String coverUrl;
  final bool isAsset;
  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onClickCard,
      child: Container(
        height: 193,
        margin: const EdgeInsets.only(top: 7, bottom: 7),
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: AppTheme.darkWidgetColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    const Color(0xff000000).withOpacity(0.35),
                    BlendMode.srcOver),
                child: isAsset
                    ? Image.asset(
                        coverUrl,
                        fit: BoxFit.cover,
                      )
                    : CustomNetworkImage(imageUrl: coverUrl),
              ),
            ),
            Positioned.fill(
              child: HorizontalPadding(
                value: 23,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: onClickStartButton != null
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    if (subTitle != null && onClickStartButton != null)
                      Text(
                        subTitle ?? "",
                        style: const TextStyle(
                          color: AppTheme.primaryColor1,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    if (subTitle != null && onClickStartButton != null) gapH6,
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subTitle != null && onClickStartButton == null) gapH6,
                    if (subTitle != null && onClickStartButton == null)
                      Text(
                        subTitle ?? "",
                        style: const TextStyle(
                          color: AppTheme.primaryColor1,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    if (onClickStartButton != null) gapH20,
                    if (onClickStartButton != null)
                      CustomButton(
                        onPressed: onClickStartButton != null
                            ? onClickStartButton!
                            : () {},
                        title: "Start Now",
                        width: 120,
                        height: 35,
                        isSmallText: true,
                      )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
