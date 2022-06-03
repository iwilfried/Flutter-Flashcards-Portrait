import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styled_text/styled_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/see_more.dart';
import '../models/slide.dart';

class SlideOne extends ConsumerStatefulWidget {
  final Slide slide;
  final String categoryName;
  final int pages;
  final Function flip;
  final FlipCardController controller;
  const SlideOne({
    Key? key,
    required this.slide,
    required this.categoryName,
    required this.pages,
    required this.flip,
    required this.controller,
  }) : super(key: key);

  @override
  ConsumerState<SlideOne> createState() => _SlideOneState();
}

class _SlideOneState extends ConsumerState<SlideOne> {
  Map<String, StyledTextTagBase> tags = {};

  @override
  void initState() {
    widget.slide.tags.forEach((element) {
      int color = int.parse("0xff" + element.color);
      FontWeight fontWeight =
          element.fontWeight == "bold" ? FontWeight.bold : FontWeight.normal;
      setState(() {
        tags.putIfAbsent(
          element.tag,
          () => element.tag == 'link'
              ? StyledTextActionTag(
                  (String? text, Map<String?, String?> attrs) async {
                    final String? link = attrs['href'];
                    launch(link!);
                  },
                  style: GoogleFonts.robotoCondensed(
                      textStyle: TextStyle(
                          fontFamily: "RobotoSerif",
                          fontWeight: fontWeight,
                          decoration: element.isUnderLine
                              ? TextDecoration.underline
                              : null,
                          fontSize:
                              (element.fontSize != 0) ? element.fontSize : null,
                          color: (element.color != "") ? Color(color) : null)),
                )
              : StyledTextTag(
                  style: GoogleFonts.robotoCondensed(
                      textStyle: TextStyle(
                          fontWeight: fontWeight,
                          decoration: element.isUnderLine
                              ? TextDecoration.underline
                              : null,
                          fontSize:
                              (element.fontSize != 0) ? element.fontSize : null,
                          color: (element.color != "") ? Color(color) : null)),
                ),
        );
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height,
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: SizedBox()),
          Container(
            width: width * .8,
            height: height * .55,
            margin: const EdgeInsets.only(
                left: 32.0, right: 32.0, top: 0.0, bottom: 0.0),
            color: Colors.transparent,
            child: FlipCard(
              controller: widget.controller,
              direction: FlipDirection.VERTICAL,
              speed: 1000,
              onFlip: () async {
                await Future.delayed(const Duration(milliseconds: 500));
                widget.flip();
              },
              onFlipDone: (status) {
                widget.flip(status: !status);
              },
              front: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Center(
                    child: StyledText(
                  textAlign: TextAlign.center,
                  text: widget.slide.firstSide,
                  style: TextStyle(
                    fontFamily: "RobotoSerif",
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 36,
                  ),
                  tags: tags,
                )),
              ),
              back: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Center(
                    child: Column(
                  children: [
                    StyledText(
                      text: widget.slide.secondSide,
                      style: TextStyle(
                        fontFamily: "RobotoSerif",
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 19,
                        height: 1.7,
                      ),
                      tags: tags,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Learn more...",
                            style: GoogleFonts.robotoCondensed(
                                textStyle: const TextStyle(
                              height: 1.7,
                              color: Colors.blue,
                              fontSize: 19,
                            )),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SeeMore(
                                            categoryName: widget.categoryName,
                                            tags: tags,
                                            text: widget.slide.learnMore)),
                                  ),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
