// Project: 	   balanced_workout
// File:    	   exercise_list_widget
// Path:    	   lib/screens/main/user/components/exercise_list_widget.dart
// Author:       Ali Akbar
// Date:        09-07-24 16:08:04 -- Tuesday
// Description:

import 'package:balanced_workout/screens/main/user/exercises/exercise_play_screen.dart';
import 'package:balanced_workout/utils/extensions/int_ext.dart';
import 'package:balanced_workout/utils/extensions/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../models/plan_model.dart';
import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../components/custom_ink_well.dart';

class ExerciseListWidget extends StatelessWidget {
  const ExerciseListWidget({super.key, required this.planExercises});
  final List<PlanExercise> planExercises;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: planExercises.length,
      padding: const EdgeInsets.symmetric(vertical: 20),
      shrinkWrap: true,
      itemBuilder: (ctx, index) {
        final PlanExercise planExercise = planExercises[index];

        return CustomInkWell(
          onTap: () {
            final exercises = List<PlanExercise>.from(planExercises)
                .skipWhile((e) => e.uuid != planExercise.uuid)
                .toList();
            NavigationService.go(
              ExercisePlayScreen(planExercises: exercises),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                      Text(
                        planExercise.exercise.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
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
                          Text(
                            planExercise.exercise.duration.formatTime(),
                            style: const TextStyle(
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
    );
  }
}
