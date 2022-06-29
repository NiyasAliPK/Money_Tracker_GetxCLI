import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:money_tracker_get_cli/app/data/controller/transaction_db_controller.dart';
import 'package:money_tracker_get_cli/app/data/models/category_model.dart';
import 'package:money_tracker_get_cli/app/data/widgets/list_tiles_for_all.dart';

class OverallTabViewAll extends StatelessWidget {
  final String selectedPeriod;
  OverallTabViewAll({Key? key, required this.selectedPeriod}) : super(key: key);
  final TransactionDatabase _transactionDatabase =
      Get.put(TransactionDatabase());
  @override
  Widget build(BuildContext context) {
    print(selectedPeriod);
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF6DD5ED), Color(0xFF2193B0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: Obx(() {
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            _transactionDatabase.getAlltransactions();
            _transactionDatabase.refreshUiForTransaction();
          },
        );
        return (_transactionDatabase.allTransactionList.isEmpty &&
                _transactionDatabase.periodSortedlsit.isEmpty)
            ? Center(
                child: Lottie.asset('assets/animations/85023-no-data.json'),
              )
            : ListView.builder(
                itemCount: selectedPeriod == 'All'
                    ? _transactionDatabase.allTransactionList.length
                    : _transactionDatabase.periodSortedlsit.length,
                itemBuilder: (BuildContext context, int index) {
                  final tempList = selectedPeriod == 'All'
                      ? _transactionDatabase.allTransactionList.reversed
                      : _transactionDatabase.periodSortedlsit.reversed;
                  final data = tempList.elementAt(index);
                  return ListCards(
                    isViewAllPage: true,
                    textColor: data.category.type == CategoryType.income
                        ? Colors.green
                        : Colors.red,
                    data: data,
                    selectedPageIndex: 0,
                    selectedPeriod: selectedPeriod,
                  );
                },
              );
      }),
    );
  }
}
