// Project: 	   balanced_workout
// File:    	   article_screen
// Path:    	   lib/screens/main/user/article_screen.dart
// Author:       Ali Akbar
// Date:        08-05-24 19:15:07 -- Wednesday
// Description:

import 'package:flutter/material.dart';

import '../../components/custom_app_bar.dart';
import '../../components/custom_scaffold.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(title: "Science and Facts"),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return const Placeholder();
        },
      ),
    );
  }
}
