import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker_get_cli/app/data/controller/common_functions.dart';
import 'package:money_tracker_get_cli/app/data/controller/transaction_db_controller.dart';
import 'package:money_tracker_get_cli/app/data/models/category_model.dart';
import 'package:money_tracker_get_cli/app/data/models/transaction_model.dart';

class EditController extends GetxController {
  final TransactionDatabase _transactionDatabase =
      Get.put(TransactionDatabase());
  bool dateChanged = false;
  DateTime datePicked = DateTime.now();

  @override
  void onClose() {}

  checkBeforeAdding(
    dynamic context,
    String amount,
    String remarks,
    TransactionModel? data,
    CategoryModel catModel,
  ) async {
    final parsedAmount = double.tryParse(amount);
    if (parsedAmount == null) {
      return;
    }

    if (remarks.isEmpty) {
      return;
    }
    final newTrans = TransactionModel(
        id: data!.id,
        date: datePicked,
        type: data.type,
        category: catModel,
        amount: parsedAmount,
        remarks: remarks,
        image: data.image);

    await _transactionDatabase.editTransactions(newTrans);

    await _transactionDatabase.piedata();
    CommonFunctions.instance.successSnackBar(context);
  }

  changeBoolState(bool value) {
    dateChanged = value;
    update();
  }

  datePicker(dynamic context, DateTime oldDate) async {
    final DateTime? picked = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        context: context,
        initialDate: oldDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != datePicked) {
      datePicked = picked;
    }
    update();
  }
}
