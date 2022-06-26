import 'package:get/get.dart';

class NavigationController extends GetxController {
  int pageIndex = 0;

  onClick(int updatedPageIndex) {
    pageIndex = updatedPageIndex;
    update();
  }
}
