import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../state_managment/dark_mode_state_manager.dart';

class ImpressumScreen extends ConsumerWidget {
  const ImpressumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: AutoSizeText("Impressum",
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: AutoSizeText(
                    "Achtung: Dieses Impressum ist Diction& Es handelt sich bei dieser App urn eine DEMO Version. ",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.robotoCondensed(
                      textStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                        height: 1.7,
                      ),
                    ))),
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: AutoSizeText(
                    "Rechtsanwalte Brell \nHammer Strasse 89 \n48153 Munster",
                    style: GoogleFonts.robotoCondensed(
                      textStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 19,
                        height: 1.7,
                      ),
                    ))),
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: AutoSizeText(
                    "Tel +49 (0) 251 322 65 44 0 \nFax: +49 (0) 251 322 65 44 99 \nMail: in(o@dimento.com ",
                    style: GoogleFonts.robotoCondensed(
                      textStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 19,
                        height: 1.7,
                      ),
                    ))),
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: AutoSizeText(
                    "Llmsatzeteueeldentifikationenummer nach \n§27a Urnsatzetenergesetz: \nDE123456789 ",
                    style: GoogleFonts.robotoCondensed(
                      textStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 19,
                        height: 1.7,
                      ),
                    ))),
          ],
        ));
  }
}
