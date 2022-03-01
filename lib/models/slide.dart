import 'tags.dart';

class Slide {
  String firstSide;
  int firstSlideFontSize;
  String secondSide;
  String learnMore;
  int secondSlideFontSize;
  List<Tags> tags;

  Slide(
      {required this.firstSide,
      required this.firstSlideFontSize,
      required this.secondSide,
      required this.learnMore,
      required this.secondSlideFontSize,
      required this.tags});

  Map<String, dynamic> toJson() => {
        "firstSide": firstSide,
        "firstSlideFontSize": firstSlideFontSize,
        "secondSide": secondSide,
        "learnMore": learnMore,
        "secondSlideFontSize": secondSlideFontSize,
        "tags": tags.toString(),
      };

  Slide.fromJson(Map<String, dynamic> json)
      : firstSide = json["firstSide"],
        firstSlideFontSize = json['firstSlideFontSize'],
        secondSide = json['secondSide'],
        learnMore = json['learnMore'],
        secondSlideFontSize = json["secondSlideFontSize"],
        tags = List<Tags>.from(json['tags'].map((e) => Tags.fromJson(e)));
}
