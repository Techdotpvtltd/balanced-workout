// Project: 	   listi_shop
// File:    	   custom_scaffold
// Path:    	   lib/screens/components/custom_scaffold.dart
// Author:       Ali Akbar
// Date:        02-04-24 20:36:11 -- Tuesday
// Description:

import 'package:flutter/material.dart';

import '../../utils/constants/app_assets.dart';
import '../../utils/constants/constants.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    this.title,
    this.body,
    this.floatingActionButton,
    this.endDrawer,
    this.floatingActionButtonLocation,
    this.scaffoldkey,
    this.resizeToAvoidBottomInset,
    this.appBar,
    this.backgroundImagePath,
  });
  final String? title;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? endDrawer;
  final String? backgroundImagePath;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final GlobalKey<ScaffoldState>? scaffoldkey;
  final bool? resizeToAvoidBottomInset;
  final PreferredSizeWidget? appBar;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: SCREEN_WIDTH,
          height: SCREEN_HEIGHT,
          child: Image.asset(
            backgroundImagePath ?? AppAssets.background,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Scaffold(
            key: scaffoldkey,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            backgroundColor: Colors.transparent,
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation: floatingActionButtonLocation,
            endDrawer: endDrawer,
            appBar: appBar,
            body: body,
          ),
        ),
      ],
    );
  }
}
