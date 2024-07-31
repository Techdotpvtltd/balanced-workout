// Project: 	   balanced_workout_panel
// File:    	   article_bloc
// Path:    	   lib/blocs/article/article_bloc.dart
// Author:       Ali Akbar
// Date:        31-07-24 16:18:25 -- Wednesday
// Description:

import 'package:balanced_workout/blocs/article/article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exceptions/app_exceptions.dart';
import '../../repos/article/article_repo_impl.dart';
import 'article_event.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc() : super(ArticleStateInitial()) {
    /// Fetch Event
    on<ArticleEventFetch>(
      (event, emit) async {
        try {
          emit(ArticleStateFetching());
          final articles = await ArticleRepo().fetchAll();
          emit(ArticleStateFetched(articles: articles));
        } on AppException catch (e) {
          emit(ArticleStateFetchFailure(exception: e));
        }
      },
    );
  }
}
