// Project: 	   balanced_workout
// File:    	   article_screen
// Path:    	   lib/screens/main/user/article_screen.dart
// Author:       Ali Akbar
// Date:        08-05-24 19:15:07 -- Wednesday
// Description:

import 'package:balanced_workout/blocs/article/article_bloc.dart';
import 'package:balanced_workout/blocs/article/article_event.dart';
import 'package:balanced_workout/blocs/article/article_state.dart';
import 'package:balanced_workout/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/custom_app_bar.dart';

import '../../components/custom_scaffold.dart';
import 'components/article_items.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late List<ArticleModel> articles = context.read<ArticleBloc>().articles;
  bool isLoading = false;

  void triggerFetchArticlesEvent() {
    context.read<ArticleBloc>().add(ArticleEventFetch());
  }

  @override
  void initState() {
    triggerFetchArticlesEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ArticleBloc, ArticleState>(
      listener: (context, state) {
        if (state is ArticleStateFetched ||
            state is ArticleStateFetching ||
            state is ArticleStateFetchFailure) {
          setState(() {
            isLoading = state.isLoading;
          });

          if (state is ArticleStateFetched) {
            setState(() {
              articles = context.read<ArticleBloc>().articles;
            });
          }
        }
      },
      child: CustomScaffold(
        appBar: customAppBar(title: "Science and Facts"),
        body: articles.isEmpty
            ? const Center(
                child: Text(
                  "No Articles",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              )
            : isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: articles.length,
                    padding: const EdgeInsets.only(
                        left: 29, right: 29, top: 18, bottom: 14),
                    itemBuilder: (context, index) {
                      return ArticleItem(article: articles[index]);
                    },
                  ),
      ),
    );
  }
}
