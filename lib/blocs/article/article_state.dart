// Project: 	   balanced_workout_panel
// File:    	   article_state
// Path:    	   lib/blocs/article/article_state.dart
// Author:       Ali Akbar
// Date:        31-07-24 16:11:20 -- Wednesday
// Description:

import 'package:balanced_workout/models/article_model.dart';

import '../../exceptions/app_exceptions.dart';

abstract class ArticleState {
  final bool isLoading;
  ArticleState({this.isLoading = false});
}

// Initial State
class ArticleStateInitial extends ArticleState {}

// ===========================Fetch All States================================
class ArticleStateFetching extends ArticleState {
  ArticleStateFetching({super.isLoading = true});
}

class ArticleStateFetchFailure extends ArticleState {
  final AppException exception;

  ArticleStateFetchFailure({required this.exception});
}

class ArticleStateFetched extends ArticleState {
  final List<ArticleModel> articles;

  ArticleStateFetched({required this.articles});
}
