import 'dart:convert';
import 'dart:io';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

String img = '';

class ControllerGetX extends GetxController {
  bool isNotificationOn = false;
  int pickedHour = 0;
  int pickedMinute = 0;
  final switchDataController = GetStorage();
  pickimage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    } else {
      update();
      final bytes = File(pickedImage.path).readAsBytesSync();
      img = base64Encode(bytes);
    }
  }

  ControllerGetX() {
    if (switchDataController.read('NotificationTurnedOn') != null) {
      isNotificationOn = switchDataController.read('NotificationTurnedOn');
      update();
    }
    if (switchDataController.read('ValueOfTimeHour') != null) {
      pickedHour = switchDataController.read('ValueOfTimeHour');
      update();
    }
    if (switchDataController.read('ValueOfTimeMinute') != null) {
      pickedMinute = switchDataController.read('ValueOfTimeMinute');
      update();
    }
  }
  changeSwitchState(bool value) async {
    isNotificationOn = value;
    await switchDataController.write('NotificationTurnedOn', isNotificationOn);
    update();
  }

  changeValueOfDate(int hour, int minute) async {
    pickedHour = hour;
    pickedMinute = minute;
    await switchDataController.write('ValueOfTimeHour', pickedHour);
    await switchDataController.write('ValueOfTimeMinute', pickedMinute);
    update();
  }

  clearStorage() async {
    await switchDataController.erase();
  }
}
