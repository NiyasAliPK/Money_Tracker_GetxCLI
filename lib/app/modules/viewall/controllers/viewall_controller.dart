import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker_get_cli/app/data/controller/transaction_db_controller.dart';

class ViewallController extends GetxController {
  final TransactionDatabase _transactionDatabase =
      Get.put(TransactionDatabase());
  List<String> periods = ['All', 'Today', 'Yesterday', 'Month', 'Custom'];
  dynamic dropdownvalue = "All";
  int selectedPageIndex = 0;
  static DateTimeRange? range;
  static DateTime startDate = DateTime.now().add(const Duration(days: -5));
  static DateTime endDate = DateTime.now();

  changePage(int value) {
    selectedPageIndex = value;
    update();
  }

  changeDropDownValue(String? value) async {
    dropdownvalue = value;
    update();
    await _transactionDatabase.sortorPeriod(
        selectedPeriod: dropdownvalue,
        selectedPageIndex: selectedPageIndex,
        start: ViewallController.startDate,
        end: ViewallController.endDate);
    update();
  }

  Future dateRangePicker(dynamic context) async {
    final initialDateRange = DateTimeRange(
        start: DateTime.now().add(const Duration(days: -2)),
        end: DateTime.now());
    final newdateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime.now(),
        initialDateRange: range ?? initialDateRange);
    if (newdateRange == null) return;

    range = newdateRange;
    startDate = range!.start;
    endDate = range!.end;

    _transactionDatabase.sorbyCustomDate(startDate, endDate, selectedPageIndex);
  }
}
