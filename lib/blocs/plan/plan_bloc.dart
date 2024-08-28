// Project: 	   balanced_workout
// File:    	   plan_bloc
// Path:    	   lib/blocs/plan/plan_bloc.dart
// Author:       Ali Akbar
// Date:        05-07-24 17:25:34 -- Friday
// Description:

import 'package:balanced_workout/blocs/plan/plan_event.dart';
import 'package:balanced_workout/blocs/plan/plan_state.dart';
import 'package:balanced_workout/exceptions/app_exceptions.dart';
import 'package:balanced_workout/models/plan_model.dart';
import 'package:balanced_workout/repos/cardio_repo.dart';
import 'package:balanced_workout/repos/stretches_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repos/challenge_repo.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanBloc() : super(PlanStateInitial()) {
    /// Cardios
    on<PlanEventFetchCardio>((event, emit) async {
      try {
        emit(PlanStateCardioFetching());
        final List<PlanModel> cardios = await CardioRepo().fetch(
          lastSnapDoc: event.lastSnapDoc,
          onLastSnap: (p0) {
            emit(PlanStateLastSnapReceived(lastSnapDoc: p0));
          },
        );
        emit(PlanStateCardioFetched(cardios: cardios));
      } on AppException catch (e) {
        emit(PlanStateCardioFetchFailure(exception: e));
      }
    });

    /// Stretches
    on<PlanEventFetchStretches>((event, emit) async {
      try {
        emit(PlanStateStretchesFetching());
        final List<PlanModel> stretchs = await StretchesRepo().fetch(
          lastSnapDoc: event.lastSnapDoc,
          onLastSnap: (p0) {
            emit(PlanStateLastSnapReceived(lastSnapDoc: p0));
          },
        );
        emit(PlanStateStretchesFetched(stretches: stretchs));
      } on AppException catch (e) {
        emit(PlanStateStretchesFetchFailure(exception: e));
      }
    });

    /// Challenge
    on<PlanEventFetchChallenge>((event, emit) async {
      try {
        emit(PlanStateChallengeFetching());
        final PlanModel challenge = await ChallengeRepo().fetch();
        emit(PlanStateChallengeFetched(challenge: challenge));
      } on AppException catch (e) {
        emit(PlanStateChallengeFetchFailure(exception: e));
      }
    });
  }
}
