// ignore_for_file: public_member_api_docs, sort_constructors_first

// Project: 	   balanced_workout_panel
// File:    	   video_model
// Path:    	   lib/models/video_model.dart
// Author:       Ali Akbar
// Date:        06-06-24 13:38:30 -- Thursday
// Description:

class VideoModel {
  final String url;
  VideoModel({
    required this.url,
  });

  VideoModel copyWith({
    String? url,
    String? coverUrl,
  }) {
    return VideoModel(
      url: url ?? this.url,
    );
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      url: map['url'] as String,
    );
  }

  @override
  String toString() => 'VideoModel(url: $url)';
}
