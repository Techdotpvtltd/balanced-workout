// Project: 	   balanced_workout
// File:    	   walkthrough_screen
// Path:    	   lib/screens/onboarding/walkthrough_screen.dart
// Author:       Ali Akbar
// Date:        03-05-24 14:31:15 -- Friday
// Description:

import 'package:flutter/material.dart';
import '../../models/walkthrough_model.dart';
import '../../utils/constants/app_assets.dart';
import '../../utils/constants/constants.dart';
import '../../utils/extensions/navigation_service.dart';
import '../components/custom_paddings.dart';
import 'login_screen.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  final List<WalkthroughModel> data = [
    WalkthroughModel(
        index: 1,
        imagePath: AppAssets.wti1,
        title: "EXPLORE THE WORLD’S\nWONDERS TODAY WITH US",
        description:
            "Start your adventure with us! Discover unforgotable\ndestinations an d hidden gems"),
    WalkthroughModel(
        index: 2,
        imagePath: AppAssets.wti2,
        title: "EXPLORE THE WORLD’S\nWONDERS TODAY WITH US",
        description:
            "Start your adventure with us! Discover unforgotable\ndestinations an d hidden gems"),
    WalkthroughModel(
        index: 3,
        imagePath: AppAssets.wti3,
        title: "EXPLORE THE WORLD’S\nWONDERS TODAY WITH US",
        description:
            "Start your adventure with us! Discover unforgotable\ndestinations an d hidden gems"),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background Image view
          Positioned.fill(
            child: Dismissible(
              dismissThresholds: {
                DismissDirection.startToEnd: currentIndex == 0 ? 1 : 0,
                DismissDirection.endToStart:
                    currentIndex == data.length - 1 ? 1 : 0
              },
              background: Container(color: Colors.black),
              resizeDuration: const Duration(microseconds: 1),
              key: Key('item$currentIndex'),
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  // Logic for left

                  setState(() {
                    currentIndex += 1;
                  });

                  return;
                }

                if (direction == DismissDirection.startToEnd) {
                  /// logic for right
                  setState(() {
                    currentIndex -= 1;
                  });
                }
              },
              child: Container(
                width: SCREEN_WIDTH,
                height: SCREEN_HEIGHT,
                foregroundDecoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                ),
                child: Image.asset(
                  data[currentIndex].imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Positioned.fill(
            child: CustomPadding(
              top: 0,
              left: 20,
              right: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Text(
                        data[currentIndex].title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 29,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      gapH12,
                      Text(
                        data[currentIndex].description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      gapH20,

                      /// Dots Widget
                      _Dots(
                        currentIndex: currentIndex,
                        numberOfDots: data.length,
                      ),
                      gapH40,

                      /// Swipe Button
                      _SwipeButton(
                        onReachedAtEnd: () {
                          NavigationService.go(const LoginScreen());
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Design Dots
class _Dots extends StatelessWidget {
  const _Dots({required this.currentIndex, required this.numberOfDots});
  final int currentIndex;
  final int numberOfDots;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SCREEN_WIDTH,
      height: 8,
      child: Align(
        alignment: Alignment.center,
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          itemCount: numberOfDots,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final bool isCurrent = currentIndex == index;
            return Container(
              width: isCurrent ? 36 : 8,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: isCurrent ? Colors.white : const Color(0xFFAAAAAA),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Swipe able button
class _SwipeButton extends StatefulWidget {
  const _SwipeButton({required this.onReachedAtEnd});
  final VoidCallback onReachedAtEnd;
  @override
  State<_SwipeButton> createState() => _SwipeButtonState();
}

class _SwipeButtonState extends State<_SwipeButton>
    with SingleTickerProviderStateMixin {
  double left = 8;
  double targetLeft = 8;
  double maxLeft = 200;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1),
      vsync: this,
    );
  }

  void _onSwipe(double value) {
    if (targetLeft >= maxLeft) {
      widget.onReachedAtEnd();
      return;
    }
    setState(() {
      targetLeft = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constratins) {
      maxLeft = constratins.maxWidth - 50;
      return Container(
        width: SCREEN_WIDTH,
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            colors: [
              const Color(0xFF3F3F3F).withOpacity(0.69),
              const Color(0xFFA5A5A5).withOpacity(0.69)
            ],
          ),
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        child: GestureDetector(
          onHorizontalDragUpdate: (details) {
            _onSwipe(details.globalPosition.dx);
          },
          onHorizontalDragEnd: (details) {
            animationController.animateTo(
              0,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOut,
            );
            setState(() {
              targetLeft = 8;
            });
          },
          child: Stack(
            children: [
              const Positioned.fill(
                child: Align(
                  child: Text(
                    "Swipe to Start",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: SizedBox(
                  width: 40.57,
                  height: 40.57,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        left: Tween<double>(
                          begin: targetLeft < maxLeft ? targetLeft : maxLeft,
                          end: 0,
                        ).animate(animationController).value,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 40.57,
                            height: 40.57,
                            decoration: const ShapeDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(0.48, -0.88),
                                end: Alignment(-0.48, 0.88),
                                colors: [Color(0xFF515151), Color(0xFFB7B7B7)],
                              ),
                              shape: OvalBorder(),
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
