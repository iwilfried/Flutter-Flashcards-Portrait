import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';

import '../state_managment/dark_mode_state_manager.dart';
import '../state_managment/current_card_state_manager.dart';
import '../slides/slide_zero.dart';
import '../slides/slide_one.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  void startLesson() {
    pageControllerH.nextPage(
        duration: const Duration(milliseconds: 3), curve: Curves.fastOutSlowIn);
  }

  String title = "";
  String lesson = "";
  int page = 0;
  List<Widget> list = [];

  PageController pageControllerH = PageController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    loadData();
    list = [
      SlideZero(startLesson, title),
    ];
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
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/slides.json");
    final jsonResult = jsonDecode(data); //latest Dart
    final slidesJson = jsonResult['slides'];
    setState(() {
      title = jsonResult['title'];
      lesson = jsonResult['lesson'];
      list = [];
      list.add(SlideZero(startLesson, title));
      slidesJson.forEach((slide) {
        list.add(SlideOne(
          firstSide: slide['First Side'],
          secondSide: slide['Second Side'],
          learnMore: slide['Learn more'],
          nextPage: nextPage,
          previousPage: previousPage,
          pages: jsonResult.length,
        ));
      });
    });
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset('assets/images/LogoMaster.png'),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$page',
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
                  '${list.length - 1}',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor.withOpacity(0.6)),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            child: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryColor,
            ),
            onSelected: (String value) => ref
                .read(darkModeStateManagerProvider.notifier)
                .switchDarkMode(),
            itemBuilder: (BuildContext context) {
              return {
                Theme.of(context).brightness == Brightness.light
                    ? 'enable dark mode'
                    : 'disable dark mode'
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
            padding: const EdgeInsets.only(left: 20, right: 12),
            color: Colors.blue,
            width: double.infinity,
            height: 45,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: GoogleFonts.robotoSlab(
                        textStyle: GoogleFonts.robotoSlab(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                      )),
                  Text(
                    lesson,
                    style: GoogleFonts.robotoSlab(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
