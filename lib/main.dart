import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/main_screen.dart';
import 'state_managment/dark_mode_state_manager.dart';

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

          /* light theme settings */
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          backgroundColor: Colors.black,
          primaryColor: Colors.white,
          /* dark theme settings */
        ),
        themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
        home: const MainScreen());
  }
}
