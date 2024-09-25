// Project: 	   balanced_workout
// File:    	   store_manager
// Path:    	   lib/app/store_manager.dart
// Author:       Ali Akbar
// Date:        25-09-24 18:42:13 -- Wednesday
// Description:

import 'dart:developer';

import 'package:balanced_workout/secrets/app_secret.dart';
import 'package:balanced_workout/utils/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'dart:io' show Platform;

class StoreManager {
  static final StoreManager _instance = StoreManager._internal();
  StoreManager._internal() {
    Platform.isIOS ? Store.appStore : Store.playStore;
  }

  factory StoreManager() => _instance;
  // late final Store _store;
  late final _apiKey =
      Platform.isIOS ? AppSecret.appleApiKey : AppSecret.googleApiKey;
  Offerings? _offerings;
  List<Package> availablePackages = [];
  bool isActive = false;

  Future<void> _performTasks() async {
    _fetchOffers();
    await _checkActiveSubscription();
  }

  Future<void> initialize() async {
    try {
      log("Initializing....", name: "Store SDK", time: DateTime.now());
      await Purchases.setLogLevel(LogLevel.debug);
      final PurchasesConfiguration configuration =
          PurchasesConfiguration(_apiKey)
            ..appUserID = null
            ..purchasesAreCompletedBy =
                const PurchasesAreCompletedByRevenueCat();
      await Purchases.configure(configuration);
      log("Initialized", name: "Store SDK", time: DateTime.now());
      await _performTasks();
    } catch (e) {
      log(e.toString(), name: "Store SDK", time: DateTime.now());
    }
  }

  /// Fetch All The offers
  Future<void> _fetchOffers() async {
    try {
      _offerings = await Purchases.getOfferings();
      _setAvailabalePackagesInOffers();
      debugPrint("Offers Fetch");
    } catch (e) {
      log(e.toString(), name: "StoreSDK-Offerings", time: DateTime.now());
    }
  }

  void _setAvailabalePackagesInOffers() {
    availablePackages = _offerings?.current?.availablePackages ?? [];
  }

  Future<void> _checkActiveSubscription() async {
    final CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    EntitlementInfo? entitlement =
        customerInfo.entitlements.all[AppSecret.entitlementID];
    isActive = entitlement?.isActive ?? false;
    debugPrint("Check Subscription: $isActive");
  }

  /// Perchase Susbcription
  Future<void> purchase(Package packageToPurchase) async {
    try {
      await Purchases.purchasePackage(packageToPurchase);
      await _checkActiveSubscription();
    } on PlatformException catch (e) {
      log(e.toString(), name: "StoreSDK-Purchasing", time: DateTime.now());
      CustomDialogs().errorBox(message: e.message);
    } catch (e) {
      log(e.toString(), name: "StoreSDK-Purchasing", time: DateTime.now());
      CustomDialogs().errorBox(message: "Subscription failed");
    }
  }
}

/// Access Global
final StoreManager storeManager = StoreManager();
