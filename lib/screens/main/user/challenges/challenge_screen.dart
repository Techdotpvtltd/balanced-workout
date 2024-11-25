// Project: 	   balanced_workout
// File:    	   challenge_screen
// Path:    	   lib/screens/main/user/challenges/challenge_screen.dart
// Author:       Ali Akbar
// Date:        28-08-24 18:16:49 -- Wednesday
// Description:

import 'package:balanced_workout/screens/main/user/challenges/challenge_exercises_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../blocs/plan/plan_bloc.dart';
import '../../../../blocs/plan/plan_event.dart';
import '../../../../blocs/plan/plan_state.dart';
import '../../../../models/plan_model.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/extensions/navigation_service.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_ink_well.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/custom_paddings.dart';
import '../../../components/custom_scaffold.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  bool isLoading = false;
  List<PlanModel> challenges = [];
  bool isReachedEnd = false;
  DocumentSnapshot? lastSnapDoc;
  final ScrollController scrollController = ScrollController();

  void triggerFetchChallengeEvent() {
    context
        .read<PlanBloc>()
        .add(PlanEventFetchChallenge(lastSnapDoc: lastSnapDoc));
  }

  void addScrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (!isReachedEnd) triggerFetchChallengeEvent();
    }
  }

  @override
  void initState() {
    scrollController.addListener(addScrollListener);
    triggerFetchChallengeEvent();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(addScrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlanBloc, PlanState>(
      listener: (context, state) {
        if (state is PlanStateLastSnapReceived) {
          isReachedEnd = state.lastSnapDoc == null;
          lastSnapDoc = state.lastSnapDoc;
        }

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
            for (final challenge in state.challenges) {
              if (!challenges.contains(challenge)) {
                challenges.add(challenge);
              }
            }
            setState(() {});
          }
        }
      },
      child: CustomScaffold(
        appBar: customAppBar(title: "Challenges"),
        body: CustomPadding(
          top: 6,
          child: Skeletonizer(
            enabled: isLoading && lastSnapDoc == null,
            child: (challenges.isEmpty && !isLoading)
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No challenges added yet.",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "Let’s keep the spirit alive!",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: scrollController,
                    itemCount: challenges.length,
                    padding: const EdgeInsets.only(top: 20),
                    itemBuilder: (_, index) {
                      final cardio = challenges[index];
                      return CustomInkWell(
                        onTap: () {
                          NavigationService.go(
                              ChallengeExerciseScreen(challenge: cardio));
                        },
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
                                        const Color(0xff000000)
                                            .withOpacity(0.35),
                                        BlendMode.srcOver),
                                    child: CustomNetworkImage(
                                        imageUrl: cardio.coverUrl ?? "")),
                              ),
                              Positioned(
                                left: 23,
                                right: 10,
                                bottom: 10,
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cardio.name,
                                        maxLines: 3,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
