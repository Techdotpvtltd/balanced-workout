// Project: 	   balanced_workout
// File:    	   content_detail_screen
// Path:    	   lib/screens/main/user/content_detail_screen.dart
// Author:       Ali Akbar
// Date:        07-05-24 16:42:04 -- Tuesday
// Description:

import 'package:balanced_workout/models/plan_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_theme.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/extensions/navigation_service.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_button.dart';
import '../../components/custom_container.dart';
import '../../components/custom_paddings.dart';
import '../../components/custom_scaffold.dart';
import 'complete_video_alert_screen.dart';
import 'components/video_cover_widget.dart';

class ContentDetailScreen extends StatefulWidget {
  const ContentDetailScreen({super.key, this.model, this.nextExercise});
  final PlanExercise? model;
  final PlanExercise? nextExercise;
  @override
  State<ContentDetailScreen> createState() => _ContentDetailScreenState();
}

class _ContentDetailScreenState extends State<ContentDetailScreen> {
  late final PlanExercise? model = widget.model;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(title: model?.exercise.name),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: HorizontalPadding(
        child: CustomButton(
          title: "Mark as completed",
          onPressed: () {
            NavigationService.go(const CompleteVideoAlertScreen());
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        padding:
            const EdgeInsets.only(left: 29, right: 29, top: 22, bottom: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Video Detail Widget
            SizedBox(
              height: SCREEN_HEIGHT * 0.3,
              child: Row(
                children: [
                  Expanded(
                    child: VideoCoverWidget(
                      onPressed: () {},
                      coverUrl: model?.exercise.coverUrl ?? "",
                    ),
                  ),
                  gapW10,

                  /// Step Widget
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "How To:",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        gapH8,
                        Expanded(
                          child: ListView.builder(
                            physics: const ScrollPhysics(),
                            itemCount: model?.exercise.steps.length,
                            itemBuilder: (context, index) {
                              final String step =
                                  model?.exercise.steps[index] ?? "";
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: AppTheme.primaryColor1,
                                      radius: 4,
                                    ),
                                    gapW8,
                                    Text(
                                      step,
                                      style: const TextStyle(
                                        color: Color(0xFF91929F),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            gapH22,

            /// Video Status Widget
            CustomContainer(
              color: const Color(0xFF202020),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Column(
                children: [
                  /// Status Title
                  Text(
                    model?.exercise.name ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  gapH10,

                  /// Status Subtile
                  if ((model?.note ?? model?.exercise.description) != null)
                    Text(
                      model?.note ?? model?.exercise.description ?? "",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  if ((model?.note ?? model?.exercise.description) != null)
                    gapH8,

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
                ],
              ),
            ),
            gapH30,

            /// Next Video Widget
            const Text(
              "Next Push Up",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 180,
              child: VideoCoverWidget(
                coverUrl:
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnzgLSjj_wWhnpSF4yB0zcGLqK0UBVG4SCnn0ugQWbGQ&s",
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
