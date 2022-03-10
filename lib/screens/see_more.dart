import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state_managment/dark_mode_state_manager.dart';
import 'package:styled_text/styled_text.dart';

class SeeMore extends ConsumerWidget {
  final String text;
  final String categoryName;
  final Map<String, StyledTextTagBase> tags;
  const SeeMore(
      {Key? key,
      required this.text,
      required this.tags,
      required this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: AutoSizeText("Learn more...",
              maxLines: 1,
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold)),
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
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: StyledText(
                      text: text,
                      style: GoogleFonts.robotoCondensed(
                        textStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 19,
                          height: 1.7,
                        ),
                      ),
                      tags: tags,
                    )),
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
                    Text(categoryName,
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
        ));
  }
}
