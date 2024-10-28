// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart' show kReleaseMode;

const String FIREBASE_COLLECTION_USER =
    "${kReleaseMode ? "Rel-" : "Dev-"}Users";
const String FIREBASE_COLLECTION_USER_PROFILES =
    "${kReleaseMode ? "Rel-" : "Dev-"}Avatars";
const FIREBASE_COLLECTION_PLANS = "${kReleaseMode ? "Rel-" : "Rel-"}Plans";
const FIREBASE_COLLECTION_WORKOUTS =
    "${kReleaseMode ? "Rel-" : "Rel-"}Workouts";

const FIREBASE_COLLECTION_COURSE = "${kReleaseMode ? "Rel-" : "Rel-"}Course";

const String FIREBASE_COLLECTION_CHAT =
    "${kReleaseMode ? "Rel-" : "Dev-"}Chats";

const FIREBASE_COLLECTION_MESSAGES =
    "${kReleaseMode ? "Rel-" : "Dev-"}Messages";

const FIREBASE_COLLECTION_ARTICLES =
    "${kReleaseMode ? "Rel-" : "Rel-"}Articles";

const FIREBASE_COLLECTION_LOG_WORKOUTS =
    "${kReleaseMode ? "Rel-" : "Rel-"}Log-Workouts";

const FIREBASE_COLLECTION_LOG_EXERCISES =
    "${kReleaseMode ? "Rel-" : "Rel-"}Log-Exercises";
