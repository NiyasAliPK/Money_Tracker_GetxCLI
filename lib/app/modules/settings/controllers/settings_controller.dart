import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:money_tracker_get_cli/app/data/controller/common_controller.dart';
import 'package:money_tracker_get_cli/app/data/controller/notifications.dart';
import 'package:money_tracker_get_cli/app/modules/navigation/views/navigation_view.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    NotificationApi().init(initScheduled: true);
    listenNotifications();
  }

  void listenNotifications() {
    NotificationApi.onNotifications.listen(onClickNotifications);
  }

  onClickNotifications(String? payload) {
    Get.offAll(() => NavigationView());
    return null;
  }

  final ControllerGetX _controller = Get.put(ControllerGetX());

  static TimeOfDay time = TimeOfDay.now();
  TimeOfDay selectedTime = time;
  String version = '';

  timeSelector(dynamic context) async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: time,
      initialEntryMode: TimePickerEntryMode.dial,
    );

    changeDate(newTime);

    if (newTime != null && newTime != time) {
      NotificationApi.showScheduledNotifications(
          title: 'Money Tracker',
          body: "Don't Forget To Add Your Transaction",
          scheduledTime: Time(newTime.hour, newTime.minute, 0));
      await _controller.changeValueOfDate(newTime.hour, newTime.minute);
    }
  }

  changeDate(TimeOfDay? newTime) {
    selectedTime = newTime ?? TimeOfDay.now();
    update();
  }

  getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versions = packageInfo.version;
    version = versions;
    update();
  }
}
