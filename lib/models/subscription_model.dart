// Project: 	   balanced_workout
// File:    	   subscription_model
// Path:    	   lib/models/subscription_model.dart
// Author:       Ali Akbar
// Date:        13-10-24 23:27:02 -- Sunday
// Description:

import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionModel {
  final String identifier;
  final String title;
  final PackageType? packageType;
  final StoreProduct? storeProduct;
  final bool isActive;
  final String period;

  /// The latest purchase or renewal date for the entitlement.
  final String latestPurchaseDate;

  /// True if the underlying subscription is set to renew at the end of
  /// the billing period (expirationDate).
  final bool willRenew;

  /// The first date this entitlement was purchased
  final String originalPurchaseDate;

  SubscriptionModel(
      {required this.identifier,
      required this.title,
      this.packageType,
      this.storeProduct,
      required this.isActive,
      required this.latestPurchaseDate,
      required this.willRenew,
      required this.period,
      required this.originalPurchaseDate});
}
