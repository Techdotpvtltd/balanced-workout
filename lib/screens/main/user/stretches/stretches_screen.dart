import 'package:balanced_workout/screens/main/user/settings/subscription_screen.dart';
import 'package:balanced_workout/screens/main/user/stretches/stretches_exercises_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../app/store_manager.dart';
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

class StretchesScreen extends StatefulWidget {
  const StretchesScreen({super.key});

  @override
  State<StretchesScreen> createState() => _StretchesScreenState();
}

class _StretchesScreenState extends State<StretchesScreen> {
  bool isLoading = false;
  List<PlanModel> stretches = [];
  bool isReachedEnd = false;
  DocumentSnapshot? lastSnapDoc;
  final ScrollController scrollController = ScrollController();
  late final isAllowContent = storeManager.hasSubscription;

  void addScrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (!isReachedEnd) triggerFetchStretchesEvent();
    }
  }

  void triggerFetchStretchesEvent() {
    context
        .read<PlanBloc>()
        .add(PlanEventFetchStretches(lastSnapDoc: lastSnapDoc));
  }

  @override
  void initState() {
    scrollController.addListener(addScrollListener);
    triggerFetchStretchesEvent();
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

        if (state is PlanStateStretchesFetchFailure ||
            state is PlanStateStretchesFetched ||
            state is PlanStateStretchesFetching) {
          setState(() {
            isLoading = state.isLoading;
          });

          if (state is PlanStateStretchesFetchFailure) {
            debugPrint(state.exception.message);
          }
          if (state is PlanStateStretchesFetched) {
            for (final cardio in state.stretches) {
              if (!stretches.contains(cardio)) {
                stretches.add(cardio);
              }
            }
            setState(() {});
          }
        }
      },
      child: CustomScaffold(
        appBar: customAppBar(title: "Stretches"),
        body: CustomPadding(
          top: 6,
          child: Skeletonizer(
            enabled: isLoading && lastSnapDoc == null,
            child: (stretches.isEmpty && !isLoading)
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No stretches available at the moment.",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "Stay tuned for new ones!",
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
                    itemCount: stretches.length,
                    padding: const EdgeInsets.only(top: 20),
                    itemBuilder: (_, index) {
                      final stretch = stretches[index];
                      return CustomInkWell(
                        onTap: () {
                          NavigationService.go(isAllowContent
                              ? StretchesExercisesScreen(stretches: stretch)
                              : const SubscriptionScreen());
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
                                        imageUrl: stretch.coverUrl ?? "")),
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
                                        stretch.name,
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
                              ),
                              if (!isAllowContent)
                                const Positioned(
                                  right: 10,
                                  top: 10,
                                  child: Icon(
                                    Icons.lock,
                                    size: 24,
                                    color: AppTheme.primaryColor1,
                                  ),
                                ),
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
