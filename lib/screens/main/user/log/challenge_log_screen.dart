// Project: 	   balanced_workout
// File:    	   challenge_log_screen
// Path:    	   lib/screens/main/user/log/challenge_log_screen.dart
// Author:       Ali Akbar
// Date:        07-08-24 19:52:49 -- Wednesday
// Description:

import 'package:balanced_workout/app/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/plan/plan_bloc.dart';
import '../../../../blocs/plan/plan_event.dart';
import '../../../../blocs/plan/plan_state.dart';
import '../../../../models/plan_model.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/constants/enum.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_network_image.dart';
import '../components/exercise_list_widget.dart';

class ChallengeLogScreen extends StatefulWidget {
  const ChallengeLogScreen({super.key});

  @override
  State<ChallengeLogScreen> createState() => _ChallengeLogScreenState();
}

class _ChallengeLogScreenState extends State<ChallengeLogScreen> {
  PlanModel? challenge = CacheChallenege().getItem;
  bool isLoading = false;

  void triggerFetchChallengeEvent() {
    context.read<PlanBloc>().add(PlanEventFetchChallenge());
  }

  @override
  void initState() {
    triggerFetchChallengeEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlanBloc, PlanState>(
      listener: (context, state) {
        if (state is PlanStateChallengeFetchFailure ||
            state is PlanStateChallengeFetched ||
            state is PlanStateChallengeFetching) {
          setState(() {
            isLoading = state.isLoading;
          });

          if (state is PlanStateChallengeFetchFailure) {
            debugPrint(state.exception.message);
          }
          if (state is PlanStateChallengeFetched) {
            setState(() {
              challenge = state.challenge;
            });
          }
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Stack(
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
                      child: CustomNetworkImage(
                        imageUrl: challenge?.coverUrl ?? "",
                      ),
                    ),
                  ),
                ),

                /// Custom App Bar
                customAppBar(title: "Recent Challenges"),
              ],
            ),

            /// Contents
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 30, left: 29, right: 29),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Exercises",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),

                    /// Play List Widget
                    ExerciseListWidget(
                      planExercises: challenge?.exercises ?? [],
                      type: PlanType.challenge,
                      isFromChallengeLogs: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
