import 'package:get/get.dart';
import 'package:top_care/controllers/homeController.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeViewModel());
  }
}
