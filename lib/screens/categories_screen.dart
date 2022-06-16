import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/category.dart';
import '../state_managment/categories_state_manager.dart';
import 'slides_screen.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  final String title;
  final String lesson;
  const CategoriesScreen({Key? key, required this.title, required this.lesson})
      : super(key: key);

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  int selected = -1;

  @override
  Widget build(BuildContext context) {
    List<Category> categories = ref.watch(categoriesStateManagerProvider);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Card(
              child: ExpansionTile(
                key: GlobalKey(),
                initiallyExpanded: index == selected,
                onExpansionChanged: ((newState) {
                  if (newState) {
                    setState(() {
                      const Duration(seconds: 20000);
                      selected = index;
                    });
                  } else {
                    setState(() {
                      selected = -1;
                    });
                  }
                }),
                tilePadding: const EdgeInsets.all(20),
                title: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        categories[index].categoryName,
                        maxLines: 1,
                        style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).primaryColor,
                            fontSize: 27,
                          ),
                        ),
                      ),
                      AutoSizeText(
                        "Fashcard Maker: ${categories[index].flashCardMaker}",
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: Padding(
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
                          padding: const EdgeInsets.all(10.0),
                        ),
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SlidesScreen(
                              category: categories[index],
                            ),
                          ),
                        ),
                        child: Text(
                          'Start Studying',
                          style: GoogleFonts.robotoSlab(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                        ),
                        onPressed: () => ref
                            .read(categoriesStateManagerProvider.notifier)
                            .resetAnswers(categories[index].categoryName),
                        child: Row(
                          children: [
                            const Icon(Icons.settings_backup_restore_outlined),
                            const SizedBox(width: 5),
                            Text(
                              'Reset',
                              style: GoogleFonts.robotoSlab(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                children: [
                  const Divider(
                    height: 1,
                    thickness: 2,
                  ),
                  Container(
                    width: width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Text(
                      categories[index].explanation,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).primaryColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
