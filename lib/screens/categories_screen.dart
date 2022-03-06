import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../state_managment/dark_mode_state_manager.dart';
import '../models/category.dart';
import '../screens/main_screen.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  List<Category> categories = [];
  String title = "";
  String lesson = "";

  Future<void> loadData() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/slides.json");
    final jsonResult = jsonDecode(data); //latest Dart
    final catJson = jsonResult['Categories'];
    setState(() {
      title = jsonResult['title'];
      lesson = jsonResult['lesson'];
      categories =
          List<Category>.from(catJson.map((e) => Category.fromJson(e)));
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
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
                      SizedBox(
                        height: 30,
                        child: Image.asset('assets/images/LogoMaster.png'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: Text("Select Category",
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold)),
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
                ),
              ],
            ),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).backgroundColor.withOpacity(0.9),
                      BlendMode.darken),
                  image: AssetImage(isPortrait
                      ? "assets/images/backPortrait.png"
                      : "assets/images/backLandscape.png"),
                  fit: BoxFit.cover)),
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AutoSizeText(
                          categories[index].categoryName,
                          maxLines: 1,
                          style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 27,
                          )),
                        ),
                        AutoSizeText(
                          "Fashcard Maker: ${categories[index].flashCardMaker}",
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xffF16623),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1.0)),
                                  padding: const EdgeInsets.all(5.0),
                                ),
                                onPressed: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen(
                                          title: title,
                                          lesson: lesson,
                                          slides: categories[index].slides)),
                                ),
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
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}
