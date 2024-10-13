// Project: 	   balanced_workout
// File:    	   subscription_state
// Path:    	   lib/blocs/subscription/subscription_state.dart
// Author:       Ali Akbar
// Date:        13-10-24 23:04:02 -- Sunday
// Description:

abstract class SubscriptionState {
  final bool isLoading;

  SubscriptionState({this.isLoading = false});
}

// initial state

class SubscriptionStateInitial extends SubscriptionState {}

class SubscriptionStateUpdated extends SubscriptionState {}
