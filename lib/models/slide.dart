class Slide {
  String firstSide;
  int firstSlideFontSize;
  String secondSide;
  int secondSlideFontSize;

  Slide(
      {required this.firstSide,
      required this.firstSlideFontSize,
      required this.secondSide,
      required this.secondSlideFontSize});

  Map<String, dynamic> toJson() => {
        "firstSide": firstSide,
        "firstSlideFontSize": firstSlideFontSize,
        "secondSide": secondSide,
        "secondSlideFontSize": secondSlideFontSize,
      };

  Slide.fromJson(Map<String, dynamic> json)
      : firstSide = json["firstSide"],
        firstSlideFontSize = json['firstSlideFontSize'],
        secondSide = json['secondSide'],
        secondSlideFontSize = json["secondSlideFontSize"];
}
