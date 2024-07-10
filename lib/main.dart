import 'package:balanced_workout/blocs/chat/%20chat_bloc.dart';
import 'package:balanced_workout/blocs/course/course_bloc.dart';
import 'package:balanced_workout/blocs/plan/plan_bloc.dart';
import 'package:balanced_workout/blocs/workout/workout_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app_bloc_observer.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/user/user_bloc.dart';
import 'firebase_options.dart';
import 'screens/onboarding/splash_screen.dart';
// Project: 	   balanced_workout
// File:    	   app
// Path:    	   lib/screens/app/app.dart
// Author:       Ali Akbar
// Date:        03-05-24 13:16:18 -- Saturday
// Description:

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Bloc.observer = AppBlocObserver();
  //  1 - Ensure firebase app is initialized if starting from background/terminated state
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => PlanBloc()),
        BlocProvider(create: (context) => WorkoutBloc()),
        BlocProvider(create: (context) => CourseBloc()),
        BlocProvider(create: (context) => ChatBloc()),
      ],
      child: MaterialApp(
        navigatorKey: navKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'SfProDisplay',
          scaffoldBackgroundColor: const Color(0xFF161616),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
