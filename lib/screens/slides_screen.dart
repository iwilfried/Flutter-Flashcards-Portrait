import 'package:flutter/material.dart';
import 'package:flutter_flashcards_portrait/models/slide.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';

import '../state_managment/dark_mode_state_manager.dart';
import '../state_managment/current_card_state_manager.dart';
import '../slides/slide_one.dart';
import 'Impressum.dart';
import 'main_screen.dart';

class SlidesScreen extends ConsumerStatefulWidget {
  final String categoryName;
  final List<Slide> slides;
  const SlidesScreen(
      {Key? key, required this.slides, required this.categoryName})
      : super(key: key);

  @override
  ConsumerState<SlidesScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<SlidesScreen> {
  int page = 0;
  bool isQuestion = true;
  List<Widget> list = [];

  PageController pageControllerH = PageController();

  @override
  void initState() {
    widget.slides.forEach((newslide) {
      list.add(SlideOne(
        slide: newslide,
        categoryName: widget.categoryName,
        nextPage: nextPage,
        flip: flip,
        previousPage: previousPage,
        pages: widget.slides.length,
      ));
    });
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void flip() {
    setState(() {
      isQuestion = !isQuestion;
    });
  }

  void nextPage() {
    if (page < list.length) {
      pageControllerH.nextPage(
          duration: const Duration(milliseconds: 3),
          curve: Curves.fastOutSlowIn);
    }
  }

  void previousPage() {
    if (page > 0) {
      pageControllerH.previousPage(
          duration: const Duration(milliseconds: 3),
          curve: Curves.fastOutSlowIn);
    }
  }

  Future<void> loadData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(top: BorderSide(color: Colors.green, width: 3)),
        backgroundColor: Theme.of(context).cardColor,
        centerTitle: false,
        titleSpacing: 0,
        shadowColor: Theme.of(context).shadowColor,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainScreen()),
                      ),
                      child: SizedBox(
                        height: 30,
                        child: Image.asset('assets/images/LogoMaster.png'),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${page + 1}',
                      style: GoogleFonts.robotoCondensed(
                        textStyle: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      '/',
                      style: GoogleFonts.robotoCondensed(
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      '${list.length}',
                      style: GoogleFonts.robotoCondensed(
                        textStyle: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.6)),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton<String>(
                      child: Icon(
                        Icons.more_vert,
                        color: Theme.of(context).primaryColor,
                      ),
                      onSelected: (String value) => value == 'FlashDecks'
                          ? Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainScreen()),
                            )
                          : value == 'Impressum'
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ImpressumScreen()),
                                )
                              : ref
                                  .read(darkModeStateManagerProvider.notifier)
                                  .switchDarkMode(),
                      itemBuilder: (BuildContext context) {
                        return {
                          Theme.of(context).brightness == Brightness.light
                              ? 'Dark mode'
                              : 'Light mode, Categories',
                          'FlashDecks',
                          'Impressum',
                        }.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (int newpage) {
                setState(() {
                  page = newpage;
                });
                ref
                    .read(currentPageStateManagerProvider.notifier)
                    .changepage(page);
              },
              scrollDirection: Axis.horizontal,
              controller: pageControllerH,
              scrollBehavior:
                  ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              }),
              children: list,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.blue,
            width: double.infinity,
            height: 45,
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text(widget.categoryName,
                  style: GoogleFonts.robotoSlab(
                    textStyle: GoogleFonts.robotoSlab(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                  )),
              const Spacer(),
              Text(isQuestion ? "Question" : "Answer",
                  style: GoogleFonts.robotoSlab(
                    textStyle: GoogleFonts.robotoSlab(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                  )),
            ]),
          ),
        ],
      ),
    );
  }
}
