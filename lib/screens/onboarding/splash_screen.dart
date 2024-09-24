// Project: 	   balanced_workout
// File:    	   splash_screen
// Path:    	   lib/screens/onboarding/splash_screen.dart
// Author:       Ali Akbar
// Date:        03-05-24 13:57:39 -- Friday
// Description:

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';
import '../../utils/constants/app_assets.dart';
import '../../utils/extensions/navigation_service.dart';
import '../components/custom_scaffold.dart';
import '../main/user/main_user_screen.dart';
import 'walkthrough_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void triggerSplashEvent(AuthBloc bloc) {
    bloc.add(AuthEventSplashAction());
  }

  @override
  void initState() {
    triggerSplashEvent(context.read<AuthBloc>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateSplashActionDone) {
          NavigationService.offAll(const MainUserScreen());
        }

        if (state is AuthStateLoginRequired) {
          Future.delayed(const Duration(seconds: 1), () {
            NavigationService.off(const WalkthroughScreen());
          });
        }
      },
      child: CustomScaffold(
        backgroundImagePath: AppAssets.splashBackground,
        body: Center(
          child: Image.asset(AppAssets.logo),
        ),
      ),
    );
  }
}
