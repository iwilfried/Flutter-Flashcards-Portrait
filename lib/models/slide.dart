class Slide {
  String firstSide;
  int firstSlideFontSize;
  String secondSide;
  String learnMore;
  int secondSlideFontSize;

  Slide(
      {required this.firstSide,
      required this.firstSlideFontSize,
      required this.secondSide,
      required this.learnMore,
      required this.secondSlideFontSize});

  Map<String, dynamic> toJson() => {
        "firstSide": firstSide,
        "firstSlideFontSize": firstSlideFontSize,
        "secondSide": secondSide,
        "learnMore": learnMore,
        "secondSlideFontSize": secondSlideFontSize,
      };

  Slide.fromJson(Map<String, dynamic> json)
      : firstSide = json["firstSide"],
        firstSlideFontSize = json['firstSlideFontSize'],
        secondSide = json['secondSide'],
        learnMore = json['learnMore'],
        secondSlideFontSize = json["secondSlideFontSize"];
}
