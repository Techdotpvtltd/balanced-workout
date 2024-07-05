// Project: 	   balanced_workout
// File:    	   cardio_state
// Path:    	   lib/blocs/cardio/cardio_state.dart
// Author:       Ali Akbar
// Date:        05-07-24 17:15:22 -- Friday
// Description:

import 'package:balanced_workout/exceptions/app_exceptions.dart';
import 'package:balanced_workout/models/plan_model.dart';

abstract class PlanState {
  final bool isLoading;

  PlanState({this.isLoading = false});
}

/// initial State
class PlanStateInitial extends PlanState {}

// ===========================Fetch Cardio States================================

class PlanStateCardioFetching extends PlanState {
  PlanStateCardioFetching({super.isLoading = true});
}

class PlanStateCardioFetchFailure extends PlanState {
  final AppException exception;

  PlanStateCardioFetchFailure({required this.exception});
}

class PlanStateCardioFetched extends PlanState {
  final PlanModel cardio;

  PlanStateCardioFetched({required this.cardio});
}
