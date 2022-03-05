import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:auto_size_text/auto_size_text.dart';

class CredentialScreen extends StatelessWidget {
  final Function startLesson;
  const CredentialScreen(this.startLesson, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Theme.of(context).backgroundColor.withOpacity(0.9),
                    BlendMode.darken),
                image: AssetImage(isPortrait
                    ? "assets/images/backPortrait.png"
                    : "assets/images/backLandscape.png"),
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Spacer(),
            AutoSizeText(
              "DSGVO / GDPR",
              maxLines: 1,
              style: GoogleFonts.oswald(
                  textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: 30,
              )),
            ),
            AutoSizeText(
              "Fashcard Maker: AL",
              maxLines: 1,
              textAlign: TextAlign.start,
              style: GoogleFonts.oswald(
                  textStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
              )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xffF16623),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.0)),
                      padding: const EdgeInsets.all(12.0),
                    ),
                    onPressed: () => startLesson(),
                    child: Text('Start Studying',
                        style: GoogleFonts.robotoSlab(
                            textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ))),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
