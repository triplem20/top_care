import 'package:get/get.dart';

class TabIndexController extends GetxController {
  final RxInt _tabIndex = 0.obs;

  get tabIndex => _tabIndex.value;

  set setIndex(int newValue) {
    _tabIndex.value = newValue;
  }
}
