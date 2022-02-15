// ignore_for_file: camel_case_types
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/slide.dart';

final slideListStateManagerProvider =
    StateNotifierProvider<slideListStateManager, List<Slide>>((ref) {
  return slideListStateManager(ref.read);
});

class slideListStateManager extends StateNotifier<List<Slide>> {
  slideListStateManager(this.read, [state]) : super(state ?? []) {
    _init();
  }

  final Reader read;

  void _init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Slide> slideList = [];
    var jsonData = prefs.getString('slideList') ?? '';
    if (jsonData != '') {
      var list = json.decode(jsonData) as List<dynamic>;
      slideList = list.map((model) => Slide.fromJson(model)).toList();
    }
    state = slideList;
  }

  Future<void> addslide(Slide slide) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Slide> newList = [...state];
    newList.add(slide);
    prefs.setString('slideList', jsonEncode(newList));
    state = newList;
  }

  Future<void> deleteSlide(int slideIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Slide> newList = [...state];
    newList.removeAt(slideIndex);
    prefs.setString('slideList', jsonEncode(newList));
    state = newList;
  }
}
