// Project: 	   balanced_workout
// File:    	   recent_muscle_workout
// Path:    	   lib/screens/main/user/recent_muscle_workout.dart
// Author:       Ali Akbar
// Date:        08-05-24 17:04:07 -- Wednesday
// Description:

import 'package:balanced_workout/blocs/log/log_bloc.dart';
import 'package:balanced_workout/blocs/log/log_event.dart';
import 'package:balanced_workout/blocs/log/log_state.dart';
import 'package:balanced_workout/utils/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscle_selector/muscle_selector.dart';

import '../../../../models/logs/exercise_log_model.dart';
import '../../../../utils/constants/constants.dart';
import 'custom_weekly_date.dart';

class RecentMuscleWorkout extends StatefulWidget {
  const RecentMuscleWorkout({super.key});

  @override
  State<RecentMuscleWorkout> createState() => _RecentMuscleWorkoutState();
}

class _RecentMuscleWorkoutState extends State<RecentMuscleWorkout> {
  List<ExerciseMuscleType> muscles = [];

  void filteredData(List<ExerciseLogModel> exercises) {
    muscles = [];
    final m = exercises.map((e) => e.muscles).toList();
    setState(() {
      muscles = m.expand((e) => e).toList();
    });
  }

  void triggerFetchExerciesAtDate(DateTime date) {
    context.read<LogBloc>().add(LogEventFetchExercisesBy(date: date));
  }

  @override
  void initState() {
    triggerFetchExerciesAtDate(DateTime.now());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogBloc, LogState>(
      listener: (context, state) {
        if (state is LogStateFetchedExercisesByDate) {
          filteredData(state.exercises);
        }
      },
      child: Column(
        children: [
          /// Date View
          CustomWeeklyDate(
            onSelectedDate: (date) {
              triggerFetchExerciesAtDate(date);
            },
          ),
          gapH50,

          Transform.scale(
            scale: 1.2,
            child: MusclePickerMap(
              key: Key(muscles.toString()),
              map: Maps.BODY,
              onChanged: (_) {},
              isEditing: true,
              initialSelectedMuscles: muscles
                  .map((e) =>
                      Muscle(id: e.id, path: Path.from(Path()), title: e.name))
                  .toSet(),
              selectedColor: AppTheme.primaryColor1,
              dotColor: Colors.black,
              strokeColor: Colors.white,
            ),
          ),

          /// Body Parts Color Period Status
          // SizedBox(
          //   height: 50,
          //   child: ListView.builder(
          //     padding: const EdgeInsets.only(top: 20, left: 6, right: 6),
          //     scrollDirection: Axis.horizontal,
          //     itemCount: 3,
          //     itemBuilder: (context, index) {
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 23),
          //         child: Row(
          //           children: [
          //             /// Circle
          //             CircleAvatar(
          //               radius: 6,
          //               backgroundColor: index == 0
          //                   ? const Color(0xFFFF2424)
          //                   : index == 1
          //                       ? const Color(0xFFFBD047)
          //                       : const Color(0xFFE87A02),
          //             ),
          //             gapW10,
          //             Text(
          //               index == 0
          //                   ? "Yesterday"
          //                   : index == 1
          //                       ? "2 Days ago"
          //                       : "1 Week ago",
          //               style: const TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 14,
          //                 fontWeight: FontWeight.w600,
          //               ),
          //             )
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
