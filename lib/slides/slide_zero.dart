import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SlideZero extends StatelessWidget {
  final String title;
  final Function startLesson;
  const SlideZero(this.startLesson, this.title, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
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
        child: Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              isPortrait
                  ? Column(
                      children: [
                        Image.asset('assets/images/view.png',
                            width: 80, height: 80),
                        const SizedBox(
                          height: 15,
                        ),
                        AutoSizeText(
                          'Accelerated Learning',
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w300)),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/view.png',
                            width: 80, height: 80),
                        const SizedBox(
                          width: 20,
                        ),
                        AutoSizeText(
                          'Accelerated Learning',
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w300)),
                        ),
                      ],
                    ),
              const Spacer(),
              AutoSizeText(
                title,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 48,
                )),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                            fontSize: 18,
                          ))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
