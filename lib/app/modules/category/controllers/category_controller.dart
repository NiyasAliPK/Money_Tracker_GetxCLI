import 'package:get/get.dart';

class CategoryController extends GetxController {
  int selectedPageIndex = 0;
  int isCatSelected = -1;
  bool isbuttonPressed = false;

  onClick(int updatedPageIndex) {
    selectedPageIndex = updatedPageIndex;
    update();
  }

  changeState(int index, bool value) {
    isCatSelected = index;
    isbuttonPressed = value;
    update();
  }
}
