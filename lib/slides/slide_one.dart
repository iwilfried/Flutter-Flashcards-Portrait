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
  final String learnMore;
  final int pages;
  final Function nextPage;
  final Function previousPage;
  const SlideOne({
    Key? key,
    required this.firstSide,
    required this.secondSide,
    required this.learnMore,
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
                          child: Column(
                        children: [
                          Text(widget.secondSide,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.robotoCondensed(
                                  textStyle: TextStyle(
                                height: 1.7,
                                color: Theme.of(context).primaryColor,
                                fontSize: 19,
                              ))),
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
                                                  text: widget.learnMore)),
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
                const Divider(
                  thickness: 2,
                  height: 0,
                ),
                Container(
                  width: width,
                  decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.arrow_left,
                          color: Colors.grey,
                        ),
                        iconSize: 50,
                        onPressed: () {
                          widget.previousPage();
                        },
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.fiber_manual_record,
                          color: Colors.grey,
                        ),
                        iconSize: 27,
                        onPressed: () {
                          _controller.toggleCard();
                        },
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.arrow_right,
                          color: Colors.grey,
                        ),
                        iconSize: 50,
                        onPressed: () {
                          widget.nextPage();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
