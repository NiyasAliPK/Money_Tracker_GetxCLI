import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:money_tracker_get_cli/app/modules/stats/widgets/expense_tab.dart';
import 'package:money_tracker_get_cli/app/modules/stats/widgets/income_tab.dart';
import 'package:money_tracker_get_cli/app/modules/stats/widgets/overall_tab.dart';
import '../controllers/stats_controller.dart';

class StatsView extends GetView<StatsController> {
  final StatsController _statsController = Get.put(StatsController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: _statsController.selectedPageIndex,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(100, 150),
          child: AppBar(
            actions: [
              TextButton.icon(
                  style: TextButton.styleFrom(primary: Colors.black),
                  onPressed: () {
                    Get.toNamed("/viewall");
                  },
                  icon: const Icon(Icons.remove_red_eye),
                  label: const Text('View All'))
            ],
            title: const Text('STATS',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottom: TabBar(
              onTap: ((index) {
                _statsController.onClick(index);
              }),
              indicatorColor: Colors.black,
              tabs: const [
                Tab(text: "Overall"),
                Tab(text: "Income"),
                Tab(text: "Expense")
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: TabBarView(children: [OverallTab(), IncomeTab(), ExpenseTab()]),
      ),
    );
  }
}
