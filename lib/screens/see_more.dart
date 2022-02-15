import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SeeMore extends StatelessWidget {
  final String text;
  const SeeMore({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              text,
              style: GoogleFonts.robotoCondensed(
                  textStyle: TextStyle(
                height: 1.7,
                color: Theme.of(context).primaryColor,
                fontSize: 19,
              )),
            )));
  }
}
