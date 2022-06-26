import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker_get_cli/app/modules/add/widgets/add_categories.dart';
import 'package:money_tracker_get_cli/app/modules/add/widgets/add_expense.dart';
import 'package:money_tracker_get_cli/app/modules/add/widgets/add_income.dart';

import '../controllers/add_controller.dart';

class AddView extends GetView<AddController> {
  final int selectedpage;

  AddView({this.selectedpage = 1});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: selectedpage,
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF2193B0), Color(0xFF6DD5ED)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: const Size(100, 170),
            child: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    onPressed: () {
                      Get.offAllNamed("/navigation");
                    },
                    icon: const Icon(Icons.arrow_back))
              ],
              title: const Text('Add Transactions',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1)),
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 50),
                    child: TextButton.icon(
                        style: TextButton.styleFrom(primary: Colors.black),
                        onPressed: () {
                          Get.to(() => AddNewCats(
                                pageNumber: -1,
                                fromcatPage: false,
                              ));
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Category')),
                  ),
                ],
              ),
              bottom: const TabBar(
                indicatorColor: Colors.black,
                tabs: [Tab(text: "Income"), Tab(text: "Expense")],
              ),
            ),
          ),
          body: SafeArea(
            child: TabBarView(children: [AddIncome(), AddExpense()]),
          ),
        ),
      ),
    );
  }
}
