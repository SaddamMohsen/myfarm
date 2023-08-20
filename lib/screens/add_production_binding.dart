import 'package:get/get.dart';

import '../controller/amber_controller.dart';

class AmberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AmberController>(
      () => AmberController(),
    );
  }
}
