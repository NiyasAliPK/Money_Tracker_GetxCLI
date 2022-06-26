import 'package:get/get.dart';

import '../controllers/viewall_controller.dart';

class ViewallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewallController>(
      () => ViewallController(),
    );
  }
}
