// Project: 	   balanced_workout_panel
// File:    	   article_bloc
// Path:    	   lib/blocs/article/article_bloc.dart
// Author:       Ali Akbar
// Date:        31-07-24 16:18:25 -- Wednesday
// Description:

import 'package:balanced_workout/blocs/article/article_state.dart';
import 'package:balanced_workout/models/article_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exceptions/app_exceptions.dart';
import '../../repos/article/article_repo_impl.dart';
import 'article_event.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final List<ArticleModel> articles = [];
  ArticleBloc() : super(ArticleStateInitial()) {
    /// Fetch Event
    on<ArticleEventFetch>(
      (event, emit) async {
        try {
          emit(ArticleStateFetching());
          final data = await ArticleRepo().fetchAll();
          for (final article in data) {
            if (!articles.contains(article)) {
              articles.add(article);
            }
          }

          articles.sort((a, b) => b.createdAt.millisecondsSinceEpoch
              .compareTo(a.createdAt.millisecondsSinceEpoch));

          emit(ArticleStateFetched());
        } on AppException catch (e) {
          emit(ArticleStateFetchFailure(exception: e));
        }
      },
    );
  }
}
