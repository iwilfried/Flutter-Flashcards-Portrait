import 'glossry.dart';
import 'slide.dart';

class Category {
  String categoryName;
  String flashCardMaker;
  String explanation;
  List<Slide> slides;
  List<Glossry> glossries;

  Category({
    required this.slides,
    required this.explanation,
    required this.categoryName,
    required this.flashCardMaker,
    required this.glossries,
  });

  Category.fromJson(Map<String, dynamic> json)
      : categoryName = json["categoryName"],
        flashCardMaker = json["FlashCardMaker"],
        explanation = json["explanation"],
        slides = List<Slide>.from(json['slides'].map((e) => Slide.fromJson(e))),
        glossries = List<Glossry>.from(
            json['glossries'].map((e) => Glossry.fromJson(e)));
}
