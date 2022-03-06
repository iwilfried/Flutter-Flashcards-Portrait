import 'slide.dart';

class Category {
  String categoryName;
  String flashCardMaker;
  List<Slide> slides;

  Category({
    required this.slides,
    required this.categoryName,
    required this.flashCardMaker,
  });

  Category.fromJson(Map<String, dynamic> json)
      : categoryName = json["categoryName"],
        flashCardMaker = json["FlashCardMaker"],
        slides = List<Slide>.from(json['slides'].map((e) => Slide.fromJson(e)));
}
