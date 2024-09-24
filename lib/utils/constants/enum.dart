enum ExerciseType { media, article }

enum PlanType { course, cardio, stretches, challenge, workout }

enum Level { beginner, intermedate, advance }

enum Period {
  weekly(1),
  monthly(4),
  quarterly(26);
  // yearly(52);

  const Period(this.weeks);
  final int weeks;
}

enum ScreenType { workout, courses, cardio, stretches }
