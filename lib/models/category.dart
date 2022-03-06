import 'slide.dart';

class Category {
  String categoryName;
  List<Slide> slides;

  Category({
    required this.slides,
    required this.categoryName,
  });

  Category.fromJson(Map<String, dynamic> json)
      : categoryName = json["categoryName"],
        slides = List<Slide>.from(json['slides'].map((e) => Slide.fromJson(e)));
}
