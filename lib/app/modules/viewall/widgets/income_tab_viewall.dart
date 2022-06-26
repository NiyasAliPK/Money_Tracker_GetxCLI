import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:money_tracker_get_cli/app/data/controller/transaction_db_controller.dart';
import 'package:money_tracker_get_cli/app/data/widgets/list_tiles_for_all.dart';

// ignore: must_be_immutable
class IncomeTabViewAll extends StatelessWidget {
  final String selectedPeriod;

  IncomeTabViewAll({Key? key, required this.selectedPeriod}) : super(key: key);

  final TransactionDatabase _transactionDatabase =
      Get.put(TransactionDatabase());

  @override
  Widget build(BuildContext context) {
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
        return (_transactionDatabase.incomeTransactionList.isEmpty &&
                _transactionDatabase.periodSortedlsit.isEmpty)
            ? Center(
                child: Lottie.asset('assets/animations/85023-no-data.json'),
              )
            : ListView.builder(
                itemCount: selectedPeriod == 'All'
                    ? _transactionDatabase.incomeTransactionList.length
                    : _transactionDatabase.periodSortedlsit.length,
                itemBuilder: (BuildContext context, int index) {
                  final newList = selectedPeriod == 'All'
                      ? _transactionDatabase.incomeTransactionList.reversed
                      : _transactionDatabase.periodSortedlsit.reversed;
                  final data = newList.elementAt(index);
                  return ListCards(
                    isViewAllPage: true,
                    textColor: Colors.green,
                    data: data,
                    selectedPageIndex: 1,
                    selectedPeriod: selectedPeriod,
                  );
                },
              );
      }),
    );
  }
}
