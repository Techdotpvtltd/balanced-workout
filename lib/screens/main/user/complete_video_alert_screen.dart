// Project: 	   balanced_workout
// File:    	   complete_video_alert_screen
// Path:    	   lib/screens/main/user/complete_video_alert_screen.dart
// Author:       Ali Akbar
// Date:        07-05-24 18:12:50 -- Tuesday
// Description:

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/extensions/navigation_service.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_button.dart';
import '../../components/custom_container.dart';
import '../../components/custom_paddings.dart';
import '../../components/custom_scaffold.dart';

class CompleteVideoAlertScreen extends StatelessWidget {
  const CompleteVideoAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(),
      body: HorizontalPadding(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomContainer(
              padding: const EdgeInsets.only(
                  left: 23, right: 23, bottom: 40, top: 15),
              borderRadius: const BorderRadius.all(Radius.circular(21)),
              color: const Color(0xFF252525).withOpacity(0.7),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Image.asset(AppAssets.congratsIcon),
                  ),
                  gapH10,
                  const Text(
                    'Congratulations!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  gapH10,
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed cursus libero eget.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  gapH20,

                  /// Sttaus White Widget
                  CustomContainer(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(29)),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppAssets.clockIcon,
                              width: 12,
                              height: 12,
                              colorFilter: const ColorFilter.mode(
                                  Colors.black, BlendMode.srcIn),
                            ),
                            gapW6,
                            const Text('10 Minutes')
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppAssets.fireIcon,
                              width: 12,
                              height: 12,
                              colorFilter: const ColorFilter.mode(
                                  Colors.black, BlendMode.srcIn),
                            ),
                            gapW6,
                            const Text('3 times')
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppAssets.runnerIcon,
                              width: 12,
                              height: 12,
                            ),
                            gapW6,
                            const Text('3 KM')
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// Custom Buttons
                  gapH40,
                  CustomButton(
                    onPressed: () {
                      NavigationService.back();
                    },
                    title: 'Go to the next workout',
                  ),
                  gapH20,
                  CustomButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    title: 'Home',
                    onlyBorder: true,
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
