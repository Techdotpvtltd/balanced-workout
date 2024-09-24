// Project: 	   balanced_workout
// File:    	   plan_event
// Path:    	   lib/blocs/plan/plan_event.dart
// Author:       Ali Akbar
// Date:        05-07-24 17:24:49 -- Friday
// Description:

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PlanEvent {}

/// Fetch Cardio Event
class PlanEventFetchCardio extends PlanEvent {
  final DocumentSnapshot? lastSnapDoc;

  PlanEventFetchCardio({this.lastSnapDoc});
}

class PlanEventFetchChallenge extends PlanEvent {
  final DocumentSnapshot? lastSnapDoc;

  PlanEventFetchChallenge({this.lastSnapDoc});
}

class PlanEventFetchStretches extends PlanEvent {
  final DocumentSnapshot? lastSnapDoc;

  PlanEventFetchStretches({this.lastSnapDoc});
}
