import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flashcards_portrait/models/slide.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';

import '../models/category.dart';
import '../state_managment/categories_state_manager.dart';
import '../state_managment/dark_mode_state_manager.dart';
import '../slides/slide_one.dart';
import 'Impressum.dart';
import 'glossries_screen.dart';
import 'main_screen.dart';

class SlidesScreen extends ConsumerStatefulWidget {
  final Category category;
  const SlidesScreen({Key? key, required this.category}) : super(key: key);

  @override
  ConsumerState<SlidesScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<SlidesScreen> {
  late List<FlipCardController> _controllers;

  int page = 0;
  bool isQuestion = true;
  List<Widget> list = [];
  late String categoryName;
  late List<Slide> slides = [];

  PageController pageControllerH = PageController();

  @override
  void initState() {
    for (Slide slide in widget.category.slides) {
      if (slide.answer != true) {
        slides.add(slide);
      }
    }
    _controllers =
        List.generate(slides.length, (index) => FlipCardController());
    categoryName = widget.category.categoryName;

    for (int i = 0; i < slides.length; i++) {
      list.add(SlideOne(
        slide: slides[i],
        categoryName: categoryName,
        flip: flip,
        controller: _controllers[i],
        pages: slides.length,
      ));
    }
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void flip({bool? status}) {
    setState(() {
      if (status != null) {
        isQuestion = status;
      } else {
        isQuestion = !isQuestion;
      }
    });
  }

  void nextPage() {
    if (page < list.length - 1) {
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
    ref.watch(categoriesStateManagerProvider);
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
              IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GlossariesScreen(
                          glossries: widget.category.glossries))),
                  icon: Icon(
                    Icons.collections_bookmark,
                    color: Theme.of(context).primaryColor,
                  )),
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
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Theme.of(context).backgroundColor.withOpacity(0.9),
                    BlendMode.darken),
                image: const AssetImage("assets/images/backLandscape.png"),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(_getRightAnswersCount(slides).toString()),
                  ),
                  const Icon(
                    Icons.check_box,
                    color: Colors.green,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(_getWrongAnswersCount(slides).toString()),
                  ),
                  const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                onPageChanged: (int newpage) {
                  setState(() {
                    page = newpage;
                    isQuestion = true;
                  });
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
            if (!isQuestion)
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 40.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey.shade100,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(3.0)),
                          padding: const EdgeInsets.all(15.0),
                        ),
                        onPressed: () {
                          ref
                              .read(categoriesStateManagerProvider.notifier)
                              .switchAnswer(
                                  categoryName, slides[page].firstSide, true);

                          nextPage();
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            Text('Got it',
                                style: GoogleFonts.robotoSlab(
                                    textStyle: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ))),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:
                              Colors.grey.shade100, //const Color(0xffF16623),
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(3.0)),
                          padding: const EdgeInsets.all(15.0),
                        ),
                        onPressed: () {
                          ref
                              .read(categoriesStateManagerProvider.notifier)
                              .switchAnswer(
                                  categoryName, slides[page].firstSide, false);
                          nextPage();
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                            Text('Missed it',
                                style: GoogleFonts.robotoSlab(
                                    textStyle: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ))),
                          ],
                        ),
                      ),
                    ]),
              ),
            const Divider(
              thickness: 2,
              height: 0,
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: page == 0
                        ? const SizedBox()
                        : IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(
                              Icons.arrow_left,
                              color: Colors.grey,
                            ),
                            iconSize: 50,
                            onPressed: () {
                              previousPage();
                            },
                          ),
                  ),
                  Expanded(
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.fiber_manual_record,
                        color: Colors.grey,
                      ),
                      iconSize: 27,
                      onPressed: () {
                        _controllers[page].toggleCard();
                      },
                    ),
                  ),
                  Expanded(
                    child: page == list.length - 1
                        ? const SizedBox()
                        : IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(
                              Icons.arrow_right,
                              color: Colors.grey,
                            ),
                            iconSize: 50,
                            onPressed: () {
                              nextPage();
                            },
                          ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.blue,
              width: double.infinity,
              height: 45,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(categoryName,
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
      ),
    );
  }

  int _getWrongAnswersCount(List<Slide> slides) {
    int count = 0;
    for (Slide slide in slides) {
      if (slide.answer != null) {
        if (!slide.answer!) count++;
      }
    }
    return count;
  }

  int _getRightAnswersCount(List<Slide> slides) {
    int count = 0;
    for (Slide slide in slides) {
      if (slide.answer != null) {
        if (slide.answer!) count++;
      }
    }
    return count;
  }
}
