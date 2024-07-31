// Project: 	   balanced_workout_panel
// File:    	   article_repo
// Path:    	   lib/repos/article/article_repo_interface.dart
// Author:       Ali Akbar
// Date:        31-07-24 15:39:17 -- Wednesday
// Description:

import 'package:balanced_workout/models/article_model.dart';

abstract interface class ArticleRepoInterface {
  Future<List<ArticleModel>> fetchAll();
}
