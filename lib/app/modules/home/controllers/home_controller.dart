import 'package:get/get.dart';
import 'package:money_tracker_get_cli/app/data/controller/common_functions.dart';
import 'package:money_tracker_get_cli/app/data/models/category_model.dart';
import 'package:money_tracker_get_cli/app/data/models/transaction_model.dart';

class HomeController extends GetxController {
  double totalAmount = 0;
  double totalExpense = 0;
  double totalIncome = 0;

  CommonFunctions controller = Get.put(CommonFunctions());

  totalBalaceCalculation(RxList allTransactionList) {
    totalAmount = 0;
    totalExpense = 0;
    totalIncome = 0;

    controller.totalExpense = 0;
    controller.totalIncome = 0;

    for (TransactionModel data in allTransactionList) {
      if (data.category.type == CategoryType.income) {
        totalIncome = totalIncome + data.amount;
        totalAmount = totalAmount + data.amount;
      } else {
        totalExpense = totalExpense + data.amount;
        totalAmount = totalAmount - data.amount;
        CommonFunctions.instance.totalExpense = totalExpense;
        CommonFunctions.instance.totalIncome = totalIncome;
      }
    }
  }
}
