// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import 'tags.dart';

class Slide extends Equatable {
  String firstSide;
  String secondSide;
  String learnMore;
  List<Tags> tags;
  bool? answer;

  Slide(
      {required this.firstSide,
      required this.secondSide,
      required this.learnMore,
      required this.tags});

  Map<String, dynamic> toJson() => {
        "First Side": firstSide,
        "Second Side": secondSide,
        "Learn more": learnMore,
        "tags": List<dynamic>.from(tags.map((tag) => tag.toJson())),
        "answer": answer,
      };

  Slide.fromJson(Map<String, dynamic> json)
      : firstSide = json["First Side"],
        secondSide = json['Second Side'],
        learnMore = json['Learn more'],
        tags = json['tags'] == null
            ? []
            : List<Tags>.from(json['tags'].map((e) => Tags.fromJson(e))),
        answer = json['answer'];

  @override
  List<Object> get props => [firstSide, secondSide, learnMore, tags];
}
