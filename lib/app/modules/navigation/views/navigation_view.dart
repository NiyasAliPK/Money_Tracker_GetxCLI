import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:money_tracker_get_cli/app/modules/category/views/category_view.dart';
import 'package:money_tracker_get_cli/app/modules/home/views/home_view.dart';
import 'package:money_tracker_get_cli/app/modules/settings/views/settings_view.dart';
import 'package:money_tracker_get_cli/app/modules/stats/views/stats_view.dart';

import '../controllers/navigation_controller.dart';

class NavigationView extends GetView<NavigationController> {
  final _pages = [HomeView(), StatsView(), CategoryView(), SettingsView()];

  final NavigationController _controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF2193B0), Color(0xFF6DD5ED)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              Get.toNamed('/add');
            },
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: SafeArea(child: GetBuilder<NavigationController>(
            builder: (context) {
              return _pages[_controller.pageIndex];
            },
          )),
          bottomNavigationBar:
              GetBuilder<NavigationController>(builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BottomNavigationBar(
                    backgroundColor: Colors.white,
                    currentIndex: _controller.pageIndex,
                    onTap: ((newIndex) {
                      _controller.onClick(newIndex);
                    }),
                    type: BottomNavigationBarType.fixed,
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: 'Home'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.pie_chart), label: 'Stats'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.category), label: 'Category'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.settings), label: 'Settings'),
                    ]),
              ),
            );
          })),
    );
  }
}
