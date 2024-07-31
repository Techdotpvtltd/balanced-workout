// Project: 	   balanced_workout_panel
// File:    	   article_repo_impl
// Path:    	   lib/repos/article/article_repo_impl.dart
// Author:       Ali Akbar
// Date:        31-07-24 15:50:22 -- Wednesday
// Description:

import 'package:flutter/material.dart';
import '../../utils/constants/firebase_collections.dart';
import '../../web_services/firestore_services.dart';
import '../../web_services/query_model.dart';
import '/exceptions/exception_parsing.dart';
import '/models/article_model.dart';
import '/repos/article/article_repo_interface.dart';

class ArticleRepo implements ArticleRepoInterface {
  @override
  Future<List<ArticleModel>> fetchAll() async {
    try {
      final List<Map<String, dynamic>> data =
          await FirestoreService().fetchWithMultipleConditions(
        collection: FIREBASE_COLLECTION_ARTICLES,
        queries: [
          QueryModel(field: "createdAt", value: true, type: QueryType.orderBy),
          QueryModel(field: "", value: 40, type: QueryType.limit),
        ],
      );
      return data.map((e) => ArticleModel.fromMap(e)).toList();
    } catch (e) {
      debugPrint("Fetch Article Error: $e");
      throw throwAppException(e: e);
    }
  }
}
