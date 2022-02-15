import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/see_more.dart';

class SlideOne extends ConsumerStatefulWidget {
  final String firstSide;
  final String secondSide;
  final int pages;
  final Function nextPage;
  final Function previousPage;
  const SlideOne({
    Key? key,
    required this.firstSide,
    required this.secondSide,
    required this.pages,
    required this.nextPage,
    required this.previousPage,
  }) : super(key: key);

  @override
  ConsumerState<SlideOne> createState() => _SlideOneState();
}

class _SlideOneState extends ConsumerState<SlideOne> {
  late FlipCardController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FlipCardController();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).backgroundColor.withOpacity(0.9),
                        BlendMode.darken),
                    image: const AssetImage("assets/images/backLandscape.png"),
                    fit: BoxFit.cover)),
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
                    controller: _controller,
                    direction: FlipDirection.VERTICAL,
                    speed: 1000,
                    onFlipDone: (status) {
                      //print(status);
                    },
                    front: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Center(
                          child: Text(widget.firstSide,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.robotoCondensed(
                                  textStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 36,
                              )))),
                    ),
                    back: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Center(
                          child: widget.secondSide.length > 100
                              ? RichText(
                                  text: TextSpan(
                                      text: widget.secondSide.substring(0, 100),
                                      style: GoogleFonts.robotoCondensed(
                                          textStyle: TextStyle(
                                        height: 1.7,
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 19,
                                      )),
                                      children: [
                                        TextSpan(
                                          text: " ... read more",
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
                                                      builder: (context) =>
                                                          SeeMore(
                                                              text: widget
                                                                  .secondSide)),
                                                ),
                                        ),
                                      ]),
                                )
                              : Text(widget.secondSide,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.robotoCondensed(
                                      textStyle: TextStyle(
                                    height: 1.7,
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 19,
                                  )))),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                Container(
                  width: width * .3,
                  decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          Icons.keyboard_arrow_left_sharp,
                          color: Theme.of(context).primaryColor,
                        ),
                        iconSize: 30,
                        onPressed: () {
                          widget.previousPage();
                        },
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          Icons.refresh,
                          color: Theme.of(context).primaryColor,
                        ),
                        iconSize: 25,
                        onPressed: () {
                          _controller.toggleCard();
                        },
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          Icons.keyboard_arrow_right_sharp,
                          color: Theme.of(context).primaryColor,
                        ),
                        iconSize: 30,
                        onPressed: () {
                          widget.nextPage();
                        },
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            )));
  }
}
