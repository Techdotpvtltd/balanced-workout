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
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanBloc() : super(PlanStateInitial()) {
    /// on Cardio Event Trigger
    on<PlanEventFetchCardio>(event, emit) async {
      try {
        emit(PlanStateCardioFetching());
        final PlanModel cardio = await CardioRepo().fetch();
        emit(PlanStateCardioFetched(cardio: cardio));
      } on AppException catch (e) {
        emit(PlanStateCardioFetchFailure(exception: e));
      }
    }
  }
}
