import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker_get_cli/app/data/controller/common_controller.dart';
import 'package:money_tracker_get_cli/app/data/controller/common_functions.dart';
import 'package:money_tracker_get_cli/app/data/controller/transaction_db_controller.dart';
import 'package:money_tracker_get_cli/app/data/models/category_model.dart';
import 'package:money_tracker_get_cli/app/data/models/transaction_model.dart';

class AddController extends GetxController {
  final CommonFunctions _commonFunctions = Get.put(CommonFunctions());
  final TransactionDatabase _transactionDatabase =
      Get.put(TransactionDatabase());

  DateTime datePicked = DateTime.now();
  bool addBillClicked = false;
  CategoryModel? selectedCategoryModel;
  Object? selectedCatModelID;

  datePicker(dynamic context) async {
    final DateTime? picked = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != datePicked) {
      datePicked = picked;
      update();
    }
  }

  checkBeforeAdding(
      dynamic context, String amount, String remarks, CategoryType type) async {
    final parsedAmount = double.tryParse(amount);
    if (parsedAmount == null) {
      _commonFunctions.failedSnackBar(context, "Please input a proper amount.");
      return;
    }
    if (selectedCategoryModel == null) {
      _commonFunctions.failedSnackBar(context, "Please select a category.");
      return;
    }
    if (remarks.isEmpty) {
      _commonFunctions.failedSnackBar(
          context, "Please add a remark to your transaction.");
      return;
    }
    final newTrans = TransactionModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        date: datePicked,
        type: type,
        category: selectedCategoryModel!,
        amount: parsedAmount,
        remarks: remarks,
        image: addBillClicked == true ? img : '');
    await _transactionDatabase.addTransactions(newTrans);
    await _transactionDatabase.piedata();
    _commonFunctions.successSnackBar(context);
    Get.offAllNamed("/navigation");
  }

  oncClick(bool value) {
    addBillClicked = value;
    update();
  }

  selectCatModel(CategoryModel value) {
    selectedCategoryModel = value;
    update();
  }

  changeModelID(dynamic value) {
    selectedCatModelID = value;
    update();
  }

  // validateCategory(dynamic context, String catname, CategoryType selectedType,
  //     bool fromcatPage) async {
  //   final name = catname;
  //   if (name.trim().toString().isEmpty) {
  //     _commonFunctions.failedSnackBar(context, "Please enter a Category name.");
  //     return;
  //   }
  //   await _transactionDatabase.getAlltransactions();
  //   for (var data in _transactionDatabase.allTransactionList) {
  //     if (data.category.name.trim().toLowerCase() ==
  //             name.trim().toLowerCase() &&
  //         data.category.type == selectedType) {
  //       _commonFunctions.failedSnackBar(
  //           context, "The entered Category already exist.");
  //       return;
  //     }
  //   }
  //   final CategoryModel newCat = CategoryModel(
  //       id: DateTime.now().microsecondsSinceEpoch.toString(),
  //       name: name,
  //       type: selectedType);
  //   await _categoryDatabase.addCategories(newCat);
  //   if (fromcatPage == true) {
  //     // setState(() {});
  //     Get.back();
  //     _categoryDatabase.refreshUi();
  //   } else {
  //     if (selectedType == CategoryType.income) {
  //       // setState(() {
  //       //   widget.pageNumber = 0;
  //       // });
  //       Get.back();
  //     } else if (selectedType == CategoryType.expense) {
  //       // setState(() {
  //       //   widget.pageNumber = 1;
  //       // });
  //       Get.back();
  //     }
  //     // Get.offAll(() => ScreenAddTransactions(
  //     //       selectedpage: widget.pageNumber,
  //     //     ));
  //     Get.offAll("/add");
  //     _categoryDatabase.refreshUi();
  //     // setState(() {});
  //   }
  // }
}
