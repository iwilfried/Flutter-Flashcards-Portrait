import 'slide.dart';

class Category {
  String categoryName;
  String flashCardMaker;
  String explanation;
  List<Slide> slides;

  Category({
    required this.slides,
    required this.explanation,
    required this.categoryName,
    required this.flashCardMaker,
  });

  Category.fromJson(Map<String, dynamic> json)
      : categoryName = json["categoryName"],
        flashCardMaker = json["FlashCardMaker"],
        explanation = json["explanation"],
        slides = List<Slide>.from(json['slides'].map((e) => Slide.fromJson(e)));
}
