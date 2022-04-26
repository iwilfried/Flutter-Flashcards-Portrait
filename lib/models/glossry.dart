class Glossry {
  String title;
  List<String> questions;

  Glossry({required this.title, required this.questions});

  Glossry.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        questions = List<String>.from(json["questions"] ?? [].map((e) => e));
}
