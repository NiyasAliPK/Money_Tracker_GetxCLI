import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:money_tracker_get_cli/app/data/controller/transaction_db_controller.dart';
import 'package:money_tracker_get_cli/app/modules/viewall/widgets/expense_tab_viewall.dart';
import 'package:money_tracker_get_cli/app/modules/viewall/widgets/income_tab_viewall.dart';
import 'package:money_tracker_get_cli/app/modules/viewall/widgets/overall_tab_viewall.dart';

import '../controllers/viewall_controller.dart';

class ViewallView extends GetView<ViewallController> {
  final ViewallController _viewallController = Get.put(ViewallController());
  final TransactionDatabase _transactionDatabase =
      Get.put(TransactionDatabase());
  @override
  Widget build(BuildContext context) {
    _viewallController.onInit();
    return DefaultTabController(
      length: 3,
      initialIndex: _viewallController.selectedPageIndex,
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF6DD5ED), Color(0xFF2193B0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: const Size(100, 170),
            child: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    onPressed: () {
                      Get.offAllNamed("/navigation");
                    },
                    icon: const Icon(Icons.arrow_back))
              ],
              backgroundColor: Colors.transparent,
              title: const Text('View All',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1)),
              elevation: 0,
              flexibleSpace: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.01,
                      top: MediaQuery.of(context).size.height * 0.10,
                    ),
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        margin: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                        child: Obx(() {
                          return DropdownButton(
                            underline: const SizedBox(),
                            alignment: AlignmentDirectional.center,
                            hint: Text(_viewallController.dropdownvalue.value),
                            items:
                                _viewallController.periods.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) async {
                              // Get.offAll(() => ViewallView());

                              await _viewallController
                                  .changeDropDownValue(newValue);

                              // _transactionDatabase.sortorPeriod(
                              //     selectedPeriod:
                              //         _viewallController.dropdownvalue,
                              //     selectedPageIndex:
                              //         _viewallController.selectedPageIndex,
                              //     start: ViewallController.startDate,
                              //     end: ViewallController.endDate);

                              if (_viewallController.dropdownvalue.value ==
                                  'Custom') {
                                await _viewallController
                                    .dateRangePicker(context);
                              }
                            },
                          );
                        })),
                  )
                ],
              ),
              bottom: TabBar(
                onTap: ((index) async {
                  _viewallController.changePage(index);
                  await _transactionDatabase.sortorPeriod(
                      selectedPeriod: _viewallController.dropdownvalue.value,
                      selectedPageIndex: _viewallController.selectedPageIndex,
                      start: ViewallController.startDate,
                      end: ViewallController.endDate);
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
          body: TabBarView(
            children: [
              OverallTabViewAll(
                  selectedPeriod: _viewallController.dropdownvalue.value),
              IncomeTabViewAll(
                  selectedPeriod: _viewallController.dropdownvalue.value),
              ExpenseTabViewAll(
                  selectedPeriod: _viewallController.dropdownvalue.value)
            ],
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
