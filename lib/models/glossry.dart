import 'package:equatable/equatable.dart';
import 'package:flutter_flashcards_portrait/models/tags.dart';

class Glossry extends Equatable {
  String title;
  List<String> questions;
  List<Tags> tags;

  Glossry({required this.title, required this.questions, required this.tags});

  Glossry.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        tags = json['tags'] == null
            ? []
            : List<Tags>.from(json['tags'].map((e) => Tags.fromJson(e))),
        questions = List<String>.from(
            json["questions"] == null ? [] : json["questions"].map((e) => e));

  Map<String, dynamic> toJson() => {
        "title": title,
        "questions": List<dynamic>.from(questions.map((question) => question)),
        "tags": List<dynamic>.from(tags.map((tag) => tag.toJson())),
      };

  @override
  List<Object> get props => [title, questions];
}
