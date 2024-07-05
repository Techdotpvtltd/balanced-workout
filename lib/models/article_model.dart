// ignore_for_file: public_member_api_docs, sort_constructors_first
// Project: 	   balanced_workout_panel
// File:    	   article_model
// Path:    	   lib/models/article_model.dart
// Author:       Ali Akbar
// Date:        04-06-24 15:07:52 -- Tuesday
// Description:

class ArticleModel {
  final List<ArticleContentModel> articles;
  ArticleModel({
    required this.articles,
  });

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      articles: (map['articles'] as List<dynamic>)
          .map((e) => ArticleContentModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() => 'ArticleModel(articles: $articles)';
}

class ArticleContentModel {
  final int uuid;
  final String? heading;
  final String? paragraph;
  ArticleContentModel({
    required this.uuid,
    this.heading,
    this.paragraph,
  });

  factory ArticleContentModel.fromMap(Map<String, dynamic> map) {
    return ArticleContentModel(
      uuid: map['uuid'] as int? ?? 0,
      heading: map['heading'] != null ? map['heading'] as String : null,
      paragraph: map['paragraph'] != null ? map['paragraph'] as String : null,
    );
  }

  @override
  String toString() => 'ArticleModel(heading: $heading, paragraph: $paragraph)';
}
