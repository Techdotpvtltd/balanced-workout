// Project: 	   balanced_workout
// File:    	   plan_event
// Path:    	   lib/blocs/plan/plan_event.dart
// Author:       Ali Akbar
// Date:        05-07-24 17:24:49 -- Friday
// Description:

abstract class PlanEvent {}

/// Fetch Cardio Event
class PlanEventFetchCardio extends PlanEvent {}

class PlanEventFetchChallenge extends PlanEvent {}

class PlanEventFetchStretches extends PlanEvent {}
