import 'package:get/get.dart';

class StatsController extends GetxController {
  int selectedPageIndex = 0;

  onClick(int updatedPageIndex) {
    selectedPageIndex = updatedPageIndex;
    update();
  }
}
