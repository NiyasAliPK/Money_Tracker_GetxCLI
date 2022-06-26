import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:money_tracker_get_cli/app/data/controller/transaction_db_controller.dart';
import 'package:money_tracker_get_cli/app/data/widgets/list_tiles_for_all.dart';

import 'package:pie_chart/pie_chart.dart';

class ExpenseTab extends StatelessWidget {
  ExpenseTab({Key? key}) : super(key: key);

  final Map<String, double> dataMap = {
    'category': 60.0,
    'Category1': 20.0,
    'Category2': 10.0,
    'Category3': 10.0
  };
  final TransactionDatabase _transactionDatabase =
      Get.put(TransactionDatabase());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                Obx(() {
                  return PieChart(
                    chartRadius: MediaQuery.of(context).size.width / 2.5,
                    dataMap: _transactionDatabase.expallMap.isEmpty
                        ? dataMap
                        : _transactionDatabase.expallMap,
                  );
                })
              ],
            )),
        Expanded(
          child: Container(
            width: 350,
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                    colors: [Color(0xFF6DD5ED), Color(0xFF2193B0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
            child: Obx(() {
              WidgetsBinding.instance.addPostFrameCallback(
                //removed exclamatory from here add if anything gone wrong
                (timeStamp) {
                  _transactionDatabase.getAlltransactions();
                  _transactionDatabase.refreshUiForTransaction();
                },
              );
              return (_transactionDatabase.expenseTransactionList.isEmpty)
                  ? Center(
                      child:
                          Lottie.asset('assets/animations/85023-no-data.json'),
                    )
                  : ListView.builder(
                      itemCount:
                          _transactionDatabase.expenseTransactionList.length < 5
                              ? _transactionDatabase
                                  .expenseTransactionList.length
                              : 5,
                      itemBuilder: (BuildContext context, int index) {
                        final newList = _transactionDatabase
                            .expenseTransactionList.reversed;
                        final data = newList.elementAt(index);
                        return ListCards(
                          selectedPeriod: "All",
                          selectedPageIndex: 2,
                          isViewAllPage: false,
                          textColor: Colors.red,
                          data: data,
                        );
                      },
                    );
            }),
          ),
        )
      ],
    );
  }
}
