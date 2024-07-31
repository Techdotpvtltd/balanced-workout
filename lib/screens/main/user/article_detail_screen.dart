// Project: 	   balanced_workout
// File:    	   article_detail_screen
// Path:    	   lib/screens/main/user/article_detail_screen.dart
// Author:       Ali Akbar
// Date:        08-05-24 19:31:45 -- Wednesday
// Description:

import 'dart:convert';

import 'package:balanced_workout/models/article_model.dart';
import 'package:balanced_workout/utils/extensions/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/constants.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_network_image.dart';
import '../../components/custom_paddings.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({super.key, required this.article});
  final ArticleModel article;

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  late final ArticleModel article = widget.article;
  QuillController _controller = QuillController.basic();

  void setData() {
    // Convert JSON string to Delta
    List<dynamic> json = jsonDecode(article.data);
    final document = quill.Document.fromJson(json);

    // Initialize the QuillController with the Document

    _controller = quill.QuillController(
      document: document,
      readOnly: true,
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        title: article.title,
        background: const Color(0xFF161616),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Date Label widget
          CustomPadding(
            bottom: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(AppAssets.clockIcon),
                    gapW8,
                    Text(
                      "Published on ${article.createdAt.dateToString("MMMM dd, yyyy")}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),

                /// Cover Widget
                if (article.cover != "" && article.cover != null) gapH18,
                if (article.cover != "" && article.cover != null)
                  SizedBox(
                    height: 190,
                    width: SCREEN_WIDTH,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: CustomNetworkImage(imageUrl: article.cover ?? ""),
                    ),
                  ),
                gapH14,
              ],
            ),
          ),
          // Text Widget List
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              color: Colors.white,
              child: QuillEditor.basic(
                controller: _controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
