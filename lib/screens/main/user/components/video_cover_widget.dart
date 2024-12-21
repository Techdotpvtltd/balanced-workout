// Project: 	   balanced_workout
// File:    	   video_cover_widget
// Path:    	   lib/screens/main/user/components/video_cover_widget.dart
// Author:       Ali Akbar
// Date:        07-05-24 16:47:15 -- Tuesday
// Description:

import 'package:flutter/material.dart';

import '../../../../utils/constants/constants.dart';
import '../../../components/custom_ink_well.dart';
import '../../../components/custom_network_image.dart';

class VideoCoverWidget extends StatelessWidget {
  const VideoCoverWidget(
      {super.key,
      required this.coverUrl,
      required this.onPressed,
      this.height,
      this.width});
  final String coverUrl;
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Stack(
          children: [
            /// Background Image with Color
            Positioned.fill(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.black.withValues(alpha: 0.3), BlendMode.srcOver),
                child: CustomNetworkImage(
                  width: width ?? SCREEN_WIDTH,
                  height: height ?? SCREEN_HEIGHT,
                  imageUrl: coverUrl,
                ),
              ),
            ),

            Positioned.fill(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.play_arrow),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
