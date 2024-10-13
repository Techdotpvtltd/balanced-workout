// Project: 	   balanced_workout
// File:    	   subsription_bloc
// Path:    	   lib/blocs/subscription/subsription_bloc.dart
// Author:       Ali Akbar
// Date:        13-10-24 23:06:19 -- Sunday
// Description:

import 'package:balanced_workout/app/store_manager.dart';
import 'package:balanced_workout/blocs/subscription/subscription_state.dart';
import 'package:balanced_workout/models/subscription_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'subscription_event.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionBloc() : super(SubscriptionStateInitial()) {
    // OnSubscription buy
    on<SubscriptionEventUpdate>(
        (event, emit) => emit(SubscriptionStateUpdated()));
  }

  SubscriptionModel getActiveSubscription() {
    storeManager.checkActiveSubscription();
    final EntitlementInfo? active = storeManager.active;
    if (active != null) {
      final Package? package = storeManager.availablePackages
          .firstWhereOrNull((e) => e.identifier == active.identifier);

      return SubscriptionModel(
          identifier: active.identifier,
          title: package?.storeProduct.title ?? "--",
          packageType: package?.packageType,
          storeProduct: package?.storeProduct,
          isActive: active.isActive,
          latestPurchaseDate: active.latestPurchaseDate,
          willRenew: active.willRenew,
          period: package?.storeProduct.subscriptionPeriod == "P1M"
              ? "mon"
              : package?.storeProduct.subscriptionPeriod == "P3M"
                  ? "3mo"
                  : package?.storeProduct.subscriptionPeriod == "P1Y"
                      ? "year"
                      : "",
          originalPurchaseDate: active.originalPurchaseDate);
    }

    return SubscriptionModel(
        identifier: "",
        title: "Free",
        isActive: true,
        latestPurchaseDate: "",
        willRenew: true,
        period: "",
        originalPurchaseDate: "");
  }
}
