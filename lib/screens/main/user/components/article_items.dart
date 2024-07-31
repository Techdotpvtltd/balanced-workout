// Project: 	   balanced_workout
// File:    	   article_items
// Path:    	   lib/screens/main/user/components/article_items.dart
// Author:       Ali Akbar
// Date:        10-05-24 12:04:12 -- Friday
// Description:

import 'dart:convert';

import 'package:balanced_workout/models/article_model.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/extensions/navigation_service.dart';
import '../../../components/custom_container.dart';
import '../../../components/custom_network_image.dart';
import '../article_detail_screen.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class ArticleItem extends StatefulWidget {
  const ArticleItem({super.key, required this.article});

  final ArticleModel article;

  @override
  State<ArticleItem> createState() => _ArticleItemState();
}

class _ArticleItemState extends State<ArticleItem> {
  late ArticleModel article = widget.article;
  String? description = "";

  @override
  void initState() {
    List<dynamic> json = jsonDecode(article.data);
    final document = quill.Document.fromJson(json);
    description = document.toPlainText();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: CustomContainer(
        onPressed: () {
          NavigationService.go(ArticleDetailScreen(article: article));
        },
        padding: const EdgeInsets.only(left: 12, right: 13, top: 7, bottom: 7),
        color: AppTheme.darkWidgetColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Row(
          children: [
            /// Cover Widget
            SizedBox(
              height: 128,
              width: 148,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: CustomNetworkImage(imageUrl: article.cover ?? ""),
              ),
            ),

            /// Title Widgets
            gapW10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    article.title,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  gapH6,
                  Text(
                    description ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: const TextStyle(
                      color: AppTheme.titleColor2,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
