// ignore_for_file: camel_case_types
import 'dart:convert';
import 'package:flutter/foundation.dart' as foun;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category.dart';

final categoriesStateManagerProvider =
    StateNotifierProvider<categoriesListStateManager, List<Category>>((ref) {
  return categoriesListStateManager(ref.read);
});

class categoriesListStateManager extends StateNotifier<List<Category>> {
  categoriesListStateManager(this.read, [state]) : super(state ?? []);

  final Reader read;

  void init(List<Category> categories) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Category> saveCategories = [];
    var jsonData = prefs.getString('CategoryList') ?? '';
    if (jsonData != '') {
      try {
        var list = json.decode(jsonData) as List<dynamic>;
        saveCategories = list.map((model) => Category.fromJson(model)).toList();
      } catch (e) {
        debugPrint("decoding saved categories error: $e");
      }
    }
    if (foun.listEquals(saveCategories, categories)) {
      state = saveCategories;
    } else {
      state = categories;
    }
  }

  void switchAnswer(String catName, String sideOne, bool answer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Category> categoriesList = [...state];
    int catIndex =
        categoriesList.indexWhere((element) => element.categoryName == catName);
    int slideIndex = categoriesList[catIndex]
        .slides
        .indexWhere((element) => element.firstSide == sideOne);

    categoriesList[catIndex].slides[slideIndex].answer = answer;
    try {
      prefs.setString('CategoryList', jsonEncode(categoriesList));
    } catch (e) {
      debugPrint("encoding categories error: $e");
    }
    state = categoriesList;
  }

  void resetAnswers(String catName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Category> categoriesList = [...state];
    int catIndex =
        categoriesList.indexWhere((element) => element.categoryName == catName);
    categoriesList[catIndex].slides.forEach((element) => element.answer = null);
    prefs.setString('CategoryList', jsonEncode(categoriesList));

    state = categoriesList;
  }
}
