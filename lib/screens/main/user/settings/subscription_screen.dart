// Project: 	   balanced_workout
// File:    	   subscription_screen
// Path:    	   lib/screens/main/user/settings/subscription_screen.dart
// Author:       Ali Akbar
// Date:        09-05-24 13:10:15 -- Thursday
// Description:

import 'package:balanced_workout/app/store_manager.dart';
import 'package:balanced_workout/blocs/subscription/subscription_event.dart';
import 'package:balanced_workout/blocs/subscription/subsription_bloc.dart';
import 'package:balanced_workout/screens/onboarding/splash_screen.dart';
import 'package:balanced_workout/utils/dialogs/dialogs.dart';
import 'package:balanced_workout/utils/extensions/navigation_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_ink_well.dart';
import '../../../components/custom_paddings.dart';
import '../../../components/custom_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  late Package? activedPackage = storeManager.availablePackages
      .firstWhereOrNull((e) =>
          e.storeProduct.identifier == storeManager.active?.productIdentifier);
  late Package? selectedPackage = activedPackage;

  bool isPurchasingSubscription = false;
  bool isRestoring = false;

  final List<String> offers = [
    '- Course Exercises',
    '- Stretches Exercises',
    '- Cardio Exercises  ',
    '- Daily Challeneges',
    '- Create Communities'
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImagePath: AppAssets.cover1,
      backgrounsOpacity: 0.3,
      appBar: customAppBar(),
      body: SingleChildScrollView(
        child: CustomPadding(
          bottom: 82,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /// Title
              const Text(
                "Be Premium\nGet unlimited access",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "When you subscribe, you’ll get instant unlimited access to:",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              gapH10,
              Wrap(
                direction: Axis.horizontal,
                spacing: 32.0,
                runSpacing: 4.0,
                children: List.generate(offers.length, (i) {
                  return Text(
                    offers[i],
                    style: const TextStyle(
                      color: AppTheme.primaryColor1,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  );
                }),
              ),
              gapH40,

              /// Plan List
              _PlanList(
                selectedPackage: selectedPackage,
                onSelectPackage: (package) {
                  setState(() {
                    selectedPackage = package;
                  });
                },
              ),
              gapH50,

              /// Subscribe Now Button
              CustomButton(
                isEnabled: selectedPackage != null &&
                    selectedPackage != activedPackage,
                isLoading: isPurchasingSubscription,
                onPressed: () async {
                  try {
                    setState(() {
                      isPurchasingSubscription = true;
                    });

                    await storeManager.purchase(selectedPackage!);
                    setState(() {
                      isPurchasingSubscription = false;
                    });
                    if (context.mounted) {
                      context
                          .read<SubscriptionBloc>()
                          .add(SubscriptionEventUpdate());
                      CustomDialogs().successBox(
                        title: "Subscription Active",
                        message:
                            "Thank you for the subscription. Now you can access all the feature of this app. Please restart the app once for proper use.",
                        onPositivePressed: () {
                          NavigationService.offAll(const SplashScreen());
                        },
                        positiveTitle: "Restart",
                        barrierDismissible: false,
                      );
                    }
                  } catch (e) {
                    setState(() {
                      isPurchasingSubscription = false;
                    });
                  }
                },
                title: "Subscribe Now",
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: isRestoring
                      ? null
                      : () async {
                          try {
                            setState(() {
                              selectedPackage = null;
                              isRestoring = true;
                            });

                            await storeManager.restoreSubscription();
                            setState(() {
                              isPurchasingSubscription = false;
                            });
                            if (context.mounted) {
                              context
                                  .read<SubscriptionBloc>()
                                  .add(SubscriptionEventUpdate());
                              CustomDialogs().successBox(
                                title: "Subscription Restored",
                                message:
                                    "Your subscription is restored. Now you can access all the feature of this app. Please restart the app once for proper use.",
                                onPositivePressed: () {
                                  NavigationService.offAll(
                                      const SplashScreen());
                                },
                                positiveTitle: "Restart",
                                barrierDismissible: false,
                              );
                            }
                          } catch (e) {
                            setState(() {
                              isRestoring = false;
                            });
                          }
                        },
                  child: Text(
                    isRestoring ? "Restoring..." : "Restore subscription",
                    style: const TextStyle(color: AppTheme.primaryColor1),
                  ),
                ),
              ),
              gapH20,
              Text.rich(
                TextSpan(
                  text: "By purchasing this subscription, you agree to our ",
                  children: [
                    TextSpan(
                      text: "Privacy Policy",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(Uri.parse(
                              "https://www.freeprivacypolicy.com/live/9d9f6c3b-0ebc-408c-92da-dbfe3c94058b"));
                        },
                      style: const TextStyle(
                        color: AppTheme.primaryColor1,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: AppTheme.primaryColor1,
                      ),
                    ),
                    const TextSpan(text: " & "),
                    TextSpan(
                      text: "Terms of Use",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(Uri.parse(
                              "https://pro-akbar.github.io/balance-workout-terms/"));
                        },
                      style: const TextStyle(
                        color: AppTheme.primaryColor1,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: AppTheme.primaryColor1,
                      ),
                    ),
                    const TextSpan(
                        text:
                            ".Your subscription will automatically renew unless canceled at least 24 hours before the end of the current period."),
                  ],
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===========================Plan List================================
class _PlanList extends StatefulWidget {
  const _PlanList({this.selectedPackage, required this.onSelectPackage});
  final Package? selectedPackage;
  final Function(Package) onSelectPackage;

  @override
  State<_PlanList> createState() => _PlanListState();
}

class _PlanListState extends State<_PlanList> {
  late Package? selectedPackage = widget.selectedPackage;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int index = 0;
            index < storeManager.availablePackages.length;
            index++)
          Builder(
            builder: (context) {
              final Package package = storeManager.availablePackages[index];
              final bool isSelected = selectedPackage == package;

              return CustomInkWell(
                onTap: () {
                  selectedPackage = package;
                  widget.onSelectPackage(package);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 9),
                  padding: const EdgeInsets.only(
                      left: 25, right: 21, top: 26, bottom: 18),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.primaryColor1.withOpacity(0.16)
                        : const Color(0xFF222221),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.primaryColor1
                          : Colors.transparent,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      /// Round Widget
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 23,
                            height: 23,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppTheme.primaryColor1,
                                width: isSelected ? 5 : 1,
                              ),
                            ),
                          ),
                          gapW18,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                package.storeProduct.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              gapH4,
                              SizedBox(
                                width: 130,
                                child: Text(
                                  package.storeProduct.subscriptionPeriod ==
                                          "P1M"
                                      ? "Valid for a month"
                                      : package.storeProduct
                                                  .subscriptionPeriod ==
                                              "P3M"
                                          ? "Valid for 3 months"
                                          : package.storeProduct
                                                      .subscriptionPeriod ==
                                                  "P1Y"
                                              ? "Valid for a year"
                                              : package.storeProduct
                                                      .subscriptionPeriod ??
                                                  "",
                                  style: TextStyle(
                                    color: isSelected
                                        ? AppTheme.primaryColor1
                                        : Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      gapW10,

                      /// Price Label
                      Flexible(
                        child: Text(
                          package.storeProduct.priceString,
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
