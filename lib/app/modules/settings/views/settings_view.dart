import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:money_tracker_get_cli/app/data/controller/category_db_controller.dart';
import 'package:money_tracker_get_cli/app/data/controller/common_controller.dart';
import 'package:money_tracker_get_cli/app/data/controller/notifications.dart';
import 'package:money_tracker_get_cli/app/data/controller/transaction_db_controller.dart';
import 'package:restart_app/restart_app.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  final ControllerGetX _controller = Get.put(ControllerGetX());
  final TransactionDatabase _transactionDatabase =
      Get.put(TransactionDatabase());
  final SettingsController _settingsController = Get.put(SettingsController());
  final CategoryDatabase _categoryController = Get.put(CategoryDatabase());

  SizedBox spacer = const SizedBox(
    height: 25,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
              margin: const EdgeInsets.fromLTRB(20, 80, 20, 0),
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(255, 161, 161, 161),
                        spreadRadius: 1,
                        blurStyle: BlurStyle.normal,
                        blurRadius: 20)
                  ],
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                      colors: [Color(0xFF6DD5ED), Color(0xFF2193B0)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
              child: Column(children: [
                spacer,
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 250,
                  height: 40,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Notifications'),
                        GetBuilder<ControllerGetX>(builder: (_) {
                          return Switch(
                              value: _controller.isNotificationOn,
                              onChanged: (value) {
                                _controller.changeSwitchState(value);
                                if (_controller.isNotificationOn == false) {
                                  NotificationApi.cancelNotification();
                                } else if (_controller.isNotificationOn ==
                                    true) {
                                  NotificationApi.showScheduledNotifications(
                                      title: 'Money Tracker',
                                      body:
                                          "Don't Forget To Add Your Transaction",
                                      scheduledTime: Time(
                                          _controller.pickedHour,
                                          _controller.pickedMinute,
                                          0));
                                }
                              });
                        })
                      ]),
                ),
                GetBuilder<ControllerGetX>(builder: (_) {
                  return _controller.isNotificationOn == true
                      ? spacer
                      : Container();
                }),
                GetBuilder<ControllerGetX>(builder: (_) {
                  return Visibility(
                    visible: _controller.isNotificationOn,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 250,
                      height: 40,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Set Timer'),
                            IconButton(
                                onPressed: () async {
                                  await _settingsController
                                      .timeSelector(context);
                                },
                                icon: const Icon(Icons.timer)),
                            Text(
                                "${_controller.pickedHour} : ${_controller.pickedMinute}"),
                          ]),
                    ),
                  );
                }),
                spacer,
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 250,
                    height: 40,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('About The App'),
                        ]),
                  ),
                  onTap: () {
                    // showDialog(
                    //     context: context,
                    //     builder: (_) {
                    //       return AlertDialog(
                    //         title: const Text(
                    //             'Developed by Niyas Ali using Flutter'),
                    //         content: const Text(
                    //           'Money Tracker makes managing personal finances as easy as pie! Now easily record your personal and business financial transactions, review your daily, weekly and monthly financial data and manage your precious money with Money Tracker',
                    //           style: TextStyle(height: 2),
                    //         ),
                    //         actions: [
                    //           TextButton(
                    //               onPressed: () {
                    //                 Get.back();
                    //               },
                    //               child: const Text('Close'))
                    //         ],
                    //       );
                    //     });
                    Get.defaultDialog(
                        title: 'Developed by Niyas Ali using Flutter',
                        content: const Text(
                          'Money Tracker makes managing personal finances as easy as pie! Now easily record your personal and business financial transactions, review your daily, weekly and monthly financial data and manage your precious money with Money Tracker',
                          style: TextStyle(height: 2),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('Close'))
                        ],
                        contentPadding: EdgeInsets.all(15),
                        titlePadding: EdgeInsets.all(20));
                  },
                ),
                spacer,
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 250,
                  height: 40,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GetBuilder<SettingsController>(builder: (controller) {
                          controller.getVersion();
                          return Text(
                              "Version    ${_settingsController.version}");
                        }),
                      ]),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 146, 0, 0)),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                'Warning',
                                style: TextStyle(color: Colors.red),
                              ),
                              content: const Text(
                                  'The app will restart and all transaction data will be deleted from the app.\nAre you sure you want to continue?'),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      await _transactionDatabase
                                          .transactionDatabaseClear();
                                      await _categoryController
                                          .categoryDatabaseClear();
                                      await _controller.clearStorage();
                                      await Restart.restartApp();
                                    },
                                    child: const Text('Yes')),
                                TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text('No'))
                              ],
                            );
                          });
                    },
                    child: const Text('Reset App'))
              ])),
        ),
      ),
    );
  }
}
