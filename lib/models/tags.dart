// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Tags extends Equatable {
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

  Map<String, dynamic> toJson() => {
        "tag_name": tag,
        "fontWeight": fontWeight,
        "color": color,
        "fontSize": fontSize.toString(),
        "underLine": isUnderLine,
      };

  @override
  List<Object> get props => [tag, fontWeight, color, fontSize, isUnderLine];
}
