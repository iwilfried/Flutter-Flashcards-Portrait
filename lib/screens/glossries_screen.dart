import 'package:auto_size_text/auto_size_text.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styled_text/styled_text.dart';
import 'package:styled_text/tags/styled_text_tag.dart';
import 'package:styled_text/tags/styled_text_tag_action.dart';
import 'package:styled_text/tags/styled_text_tag_base.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/glossry.dart';
import '../state_managment/dark_mode_state_manager.dart';

class GlossariesScreen extends ConsumerStatefulWidget {
  final List<Glossry> glossries;
  const GlossariesScreen({Key? key, required this.glossries}) : super(key: key);

  @override
  ConsumerState<GlossariesScreen> createState() => _GlossariesScreenState();
}

class _GlossariesScreenState extends ConsumerState<GlossariesScreen> {
  late Map<String, StyledTextTagBase> tags = {};
  @override
  void initState() {
    widget.glossries[0].tags.forEach((element) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor, //change your color here
          ),
          shape: const Border(top: BorderSide(color: Colors.green, width: 3)),
          backgroundColor: Theme.of(context).cardColor,
          titleSpacing: 0,
          shadowColor: Theme.of(context).shadowColor,
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
                      ? 'Dark mode'
                      : 'Light mode'
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
        body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: Text(
                    "Glossary",
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: widget.glossries.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ExpansionTile(
                            key: GlobalKey(),
                            tilePadding: const EdgeInsets.all(15),
                            title: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    widget.glossries[index].title,
                                    maxLines: 1,
                                    style: GoogleFonts.robotoCondensed(
                                      textStyle: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            children: [
                              ...List<Widget>.generate(
                                  widget.glossries[index].questions.length,
                                  (i) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: StyledText(
                                    textAlign: TextAlign.center,
                                    text: widget.glossries[index].questions[i],
                                    style: GoogleFonts.robotoCondensed(
                                        textStyle: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 22,
                                    )),
                                    tags: tags,
                                  ),
                                );
                              }),
                            ],
                          ),
                        );
                      }),
                )
              ],
            )));
  }
}
