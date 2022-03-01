class Tags {
  String tag;
  String fontWeight;
  String color;
  double fontSize;

  Tags(
      {required this.tag,
      required this.fontWeight,
      required this.color,
      required this.fontSize});

  Tags.fromJson(Map<String, dynamic> json)
      : tag = json["tag_name"] ?? "",
        fontWeight = json['fontWeight'] ?? "normal",
        color = json['color'] ?? "",
        fontSize = double.tryParse(
              json['fontSize'].toString(),
            ) ??
            0;
}
