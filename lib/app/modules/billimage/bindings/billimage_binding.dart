import 'package:get/get.dart';

import '../controllers/billimage_controller.dart';

class BillimageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillimageController>(
      () => BillimageController(),
    );
  }
}
