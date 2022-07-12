import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_view/splash_view.dart';

import 'state_managment/dark_mode_state_manager.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
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
              height: 40,
            ),
            Text("Accelerated Learning",
                style: GoogleFonts.robotoMono(
                  textStyle: const TextStyle(
                    fontSize: 20,
                  ),
                )),
            const SizedBox(
              height: 100,
            ),
            Text(
              "Flash Cards",
              style: GoogleFonts.robotoCondensed(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 32)),
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
        seconds: 3,
      ),

      // SplashScreenView(
      //   navigateRoute:
      //   duration: 5000,
      //   imageSize: 130,
      //   imageSrc: "assets/images/view.png",
      //   text: "Accelerated Learning \n \n Flash Cards",
      //   textType: TextType.TyperAnimatedText,
      //   textStyle: GoogleFonts.robotoSlab(
      //     textStyle: GoogleFonts.robotoSlab(
      //         textStyle: const TextStyle(
      //             color: Colors.blue,
      //             fontWeight: FontWeight.w500,
      //             fontSize: 50)),
      //   ),
      //   // backgroundColor: Colors.white,
      // ),
    );
  }
}
