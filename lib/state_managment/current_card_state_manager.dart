import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentPageStateManagerProvider =
    StateNotifierProvider<CurrentPageStateManager, int>((ref) {
  return CurrentPageStateManager(ref.read);
});

class CurrentPageStateManager extends StateNotifier<int> {
  CurrentPageStateManager(this.read, [state]) : super(state ?? 1);

  final Reader read;

  Future<void> changepage(int newPage) async {
    state = newPage;
    state = state;
  }
}
