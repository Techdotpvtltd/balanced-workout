// Project: 	   balanced_workout
// File:    	   store_manager
// Path:    	   lib/app/store_manager.dart
// Author:       Ali Akbar
// Date:        25-09-24 18:42:13 -- Wednesday
// Description:

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'dart:io' show Platform;

import '../secrets/app_secret.dart';
import '../utils/dialogs/dialogs.dart';

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
  List<String> activeSubscriptions = [];

  Future<void> _performTasks() async {
    await _fetchOffers();
    await _checkActiveSubscription();
  }

  void clearActiveSubscription() {
    activeSubscriptions = [];
  }

  Future<void> initialize() async {
    try {
      log("Initializing....", name: "Store SDK", time: DateTime.now());
      Purchases.setLogLevel(LogLevel.debug);
      final PurchasesConfiguration configuration =
          PurchasesConfiguration(_apiKey)
            ..appUserID = FirebaseAuth.instance.currentUser?.uid
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
    activeSubscriptions = customerInfo.activeSubscriptions;
    debugPrint("Check Subscription: $activeSubscriptions");
  }

  Future<List<String>> restoreSubscription() async {
    final info = await Purchases.restorePurchases();
    activeSubscriptions = info.activeSubscriptions;
    return activeSubscriptions;
  }

  /// Perchase Susbcription
  Future<void> purchase(Package packageToPurchase) async {
    try {
      await Purchases.purchasePackage(packageToPurchase);
      await _checkActiveSubscription();
    } on PlatformException catch (e) {
      log(e.toString(), name: "StoreSDK-Purchasing", time: DateTime.now());
      CustomDialogs().errorBox(message: e.message);
      rethrow;
    } catch (e) {
      log(e.toString(), name: "StoreSDK-Purchasing", time: DateTime.now());
      CustomDialogs().errorBox(message: "Subscription failed");
      rethrow;
    }
  }
}

/// Access Global
final StoreManager storeManager = StoreManager();
