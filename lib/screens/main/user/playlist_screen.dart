// Project: 	   balanced_workout
// File:    	   playlist_screen
// Path:    	   lib/screens/main/user/playlist_screen.dart
// Author:       Ali Akbar
// Date:        07-05-24 16:08:21 -- Tuesday
// Description:

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_theme.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/extensions/navigation_service.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_ink_well.dart';
import '../../components/custom_network_image.dart';
import 'content_detail_screen.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            /// Color Blur Widget
            child: SizedBox(
              height: SCREEN_HEIGHT * 0.3,
              width: SCREEN_WIDTH,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.srcOver),

                /// Background Image
                child: const CustomNetworkImage(
                  imageUrl:
                      "https://img.freepik.com/premium-photo/portrait-happy-man-exercising-elliptical-machine_107420-30404.jpg?size=626&ext=jpg",
                ),
              ),
            ),
          ),

          /// Custom App Bar
          Positioned(
            child: customAppBar(title: "One Time Workout"),
          ),

          Positioned(
            top: SCREEN_HEIGHT - ((SCREEN_HEIGHT * 70) / 100),
            left: 29,
            right: 29,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  ),

                  /// Add Missing Button
                  child: Stack(
                    children: [
                      const Text(
                        "Add missing exercise",
                        style: TextStyle(
                          color: AppTheme.primaryColor1,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: AppTheme.primaryColor1,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Play List Widget
                Expanded(
                  child: ListView.builder(
                    physics: const ScrollPhysics(),
                    itemCount: 6,
                    padding: const EdgeInsets.only(top: 17, bottom: 40),
                    itemBuilder: (context, index) {
                      return CustomInkWell(
                        onTap: () {
                          NavigationService.go(const ContentDetailScreen());
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: const BoxDecoration(
                            color: Color(0xFF303030),
                            borderRadius: BorderRadius.all(Radius.circular(36)),
                          ),
                          child: Row(
                            children: [
                              /// Play Button
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: AppTheme.primaryColor1,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.black,
                                  size: 26,
                                ),
                              ),
                              gapW16,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Full Body stretching",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),

                                    /// Time Zone View
                                    Row(
                                      children: [
                                        SvgPicture.asset(AppAssets.clockIcon),
                                        gapW8,
                                        const Text(
                                          "10:30",
                                          style: TextStyle(
                                            color: Color(0xFF8C8C8C),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
