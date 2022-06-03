import 'package:equatable/equatable.dart';

class Glossry extends Equatable {
  String title;
  List<String> questions;

  Glossry({required this.title, required this.questions});

  Glossry.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        questions = List<String>.from(
            json["questions"] == null ? [] : json["questions"].map((e) => e));

  Map<String, dynamic> toJson() => {
        "title": title,
        "questions": List<dynamic>.from(questions.map((question) => question)),
      };

  @override
  List<Object> get props => [title, questions];
}
