class Tags {
  String tag;
  String fontWeight;
  String color;
  double fontSize;
  bool isUnderLine;

  Tags(
      {required this.tag,
      required this.fontWeight,
      required this.color,
      required this.fontSize,
      required this.isUnderLine});

  Tags.fromJson(Map<String, dynamic> json)
      : tag = json["tag_name"] ?? "",
        fontWeight = json['fontWeight'] ?? "normal",
        color = json['color'] ?? "",
        isUnderLine = json['underLine'] ?? false,
        fontSize = double.tryParse(
              json['fontSize'].toString(),
            ) ??
            0;
}
