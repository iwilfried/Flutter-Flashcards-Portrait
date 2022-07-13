import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_view/splash_view.dart';

import 'state_managment/dark_mode_state_manager.dart';
import 'screens/main_screen.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool darkMode = ref.watch(darkModeStateManagerProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Web for Slides',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xff333333),
        backgroundColor: Colors.white,
        shadowColor: const Color(0xff333333),
        cardColor: Colors.white,

        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        primaryColor: Colors.white,
        shadowColor: Colors.white24,
        cardColor: Colors.black45,

        /* dark theme settings */
      ),
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      home: SplashView(
        image: Column(
          children: [
            Image.asset(
              "assets/images/view.png",
              height: 100,
            ),
            const SizedBox(
              height: 60,
            ),
            DefaultTextStyle(
              textAlign: TextAlign.center,
              style: GoogleFonts.robotoMono(
                color: Colors.black,
                textStyle: const TextStyle(
                  fontSize: 28,
                ),
              ),
              child: AnimatedTextKit(
                isRepeatingAnimation: false,
                animatedTexts: [
                  TypewriterAnimatedText('Accelerated Learning',
                      textAlign: TextAlign.center,
                      speed: const Duration(milliseconds: 100),
                      cursor: ""),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            DefaultTextStyle(
              textAlign: TextAlign.center,
              style: GoogleFonts.robotoCondensed(
                color: Colors.black,
                textStyle:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 38),
              ),
              child: AnimatedTextKit(
                isRepeatingAnimation: false,
                animatedTexts: [
                  TypewriterAnimatedText("",
                      speed: const Duration(milliseconds: 110), cursor: ""),
                  TypewriterAnimatedText('FlashCards',
                      textAlign: TextAlign.center,
                      speed: const Duration(milliseconds: 100),
                      cursor: ""),
                ],
              ),
            ),
          ],
        ),
        title: "",
        showLoading: false,
        backgroundImage: const AssetImage("assets/images/backLandscape.png"),
        backgroundImageFit: BoxFit.cover,
        backgroundImageColorFilter: ColorFilter.mode(
          Colors.white.withOpacity(1),
          BlendMode.darken,
        ),
        home: const MainScreen(),
        seconds: 4,
      ),
    );
  }
}
