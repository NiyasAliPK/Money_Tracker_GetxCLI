import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_tracker_get_cli/app/data/models/category_model.dart';
import 'package:money_tracker_get_cli/app/data/models/transaction_model.dart';
import 'package:money_tracker_get_cli/app/modules/home/controllers/home_controller.dart';

class TransactionDatabase extends GetxController {
  final HomeController _homeController = Get.put(HomeController());

  RxList<TransactionModel> allTransactionList = <TransactionModel>[].obs;
  RxList<TransactionModel> incomeTransactionList = <TransactionModel>[].obs;
  RxList<TransactionModel> expenseTransactionList = <TransactionModel>[].obs;
  RxList<TransactionModel> periodSortedlsit = <TransactionModel>[].obs;
  RxList<TransactionModel> passedList = <TransactionModel>[].obs;
  RxList<TransactionModel> selectedCatTrans = <TransactionModel>[].obs;
  RxMap<String, double> incallMap = <String, double>{}.obs;
  RxMap<String, double> expallMap = <String, double>{}.obs;
  List<dynamic> incomecategories = [];
  List expensecategories = [];
  List incomecatname = [];
  List incomeamt = [];
  List expensecatname = [];
  List expenseamt = [];

  addTransactions(TransactionModel newTrans) async {
    final transDb = await Hive.openBox<TransactionModel>('TransactionDB2');
    await transDb.put(newTrans.id, newTrans);
    await getAlltransactions();
    await refreshUiForTransaction();
  }

  getAlltransactions() async {
    final transDb = await Hive.openBox<TransactionModel>('TransactionDB2');
    allTransactionList.clear();
    allTransactionList.addAll(transDb.values);
    await refreshUiForTransaction();
    await _homeController.totalBalaceCalculation(allTransactionList);
  }

  deleteSelectedTransaction(String id) async {
    final transDb = await Hive.openBox<TransactionModel>('TransactionDB2');
    await transDb.delete(id);
    await getAlltransactions();
    await refreshUiForTransaction();
  }

  editTransactions(TransactionModel value) async {
    final transDb = await Hive.openBox<TransactionModel>('TransactionDB2');
    await transDb.put(value.id, value);
    await getAlltransactions();
    await refreshUiForTransaction();
  }

  Future<void> refreshUiForTransaction() async {
    expenseTransactionList.clear();
    incomeTransactionList.clear();
    Future.forEach(allTransactionList, (TransactionModel transaction) {
      if (transaction.type == CategoryType.income) {
        incomeTransactionList.add(transaction);
      } else {
        expenseTransactionList.add(transaction);
      }
    });
  }

  sortorPeriod(
      {required String selectedPeriod,
      required int selectedPageIndex,
      DateTime? start,
      DateTime? end}) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    switch (selectedPeriod) {
      // case 'All':
      //   await sortedListForPeriods(today, selectedPageIndex);
      //   break;
      case 'Today':
        await sortedListForPeriods(today, selectedPageIndex);
        break;
      case 'Yesterday':
        await sortedListForPeriods(yesterday, selectedPageIndex);
        break;
      case 'Month':
        await sortbyMonth(today, selectedPageIndex);
        break;
      case 'Custom':
        await sorbyCustomDate(start!, end!, selectedPageIndex);
        break;
      default:
    }
  }

  sortedListForPeriods(DateTime selected, int selectedPageIndex) async {
    periodSortedlsit.clear();
    passedList.clear();
    if (selectedPageIndex == 0) {
      passedList.clear();
      passedList.addAll(allTransactionList);
    } else if (selectedPageIndex == 1) {
      passedList.clear();
      passedList.addAll(incomeTransactionList);
    } else if (selectedPageIndex == 2) {
      passedList.clear();
      passedList.addAll(expenseTransactionList);
    }

    await Future.forEach(passedList, (TransactionModel data) {
      if ((data.date.day == selected.day &&
              data.date.month == selected.month) ||
          (data.date.day == selected.day)) {
        periodSortedlsit.add(data);
      }
    });
  }

  sortbyMonth(DateTime selected, int selectedPageIndex) async {
    periodSortedlsit.clear();
    passedList.clear();
    if (selectedPageIndex == 0) {
      passedList.clear();
      passedList.addAll(allTransactionList);
    } else if (selectedPageIndex == 1) {
      passedList.clear();
      passedList.addAll(incomeTransactionList);
    } else if (selectedPageIndex == 2) {
      passedList.clear();
      passedList.addAll(expenseTransactionList);
    }
    await Future.forEach(passedList, (TransactionModel data) {
      if (data.date.month == selected.month) {
        periodSortedlsit.add(data);
      }
    });
  }

  sorbyCustomDate(DateTime start, DateTime end, int selectedPageIndex) async {
    periodSortedlsit.clear();
    passedList.clear();
    if (selectedPageIndex == 0) {
      passedList.clear();
      passedList.addAll(allTransactionList);
    } else if (selectedPageIndex == 1) {
      passedList.clear();
      passedList.addAll(incomeTransactionList);
    } else if (selectedPageIndex == 2) {
      passedList.clear();
      passedList.addAll(expenseTransactionList);
    }
    await Future.forEach(passedList, (TransactionModel data) {
      if (((data.date.day >= start.day) && (data.date.month == start.month)) &&
          ((data.date.day <= end.day) &&
              (data.date.month == end.month) &&
              ((data.date.year == end.year) &&
                  (data.date.year == start.year)))) {
        periodSortedlsit.add(data);
      }
    });
  }

  sortForSelectedCat(String selectedCatName, int pageIndex) async {
    selectedCatTrans.clear();
    List<TransactionModel> tempList = [];
    if (pageIndex == 0) {
      tempList.addAll(incomeTransactionList);
      selectedCatTrans.clear();
    } else if (pageIndex == 1) {
      tempList.addAll(expenseTransactionList);
      selectedCatTrans.clear();
    }
    await Future.forEach(tempList, (TransactionModel data) {
      if (data.category.name == selectedCatName &&
          data.category.isDeleted == false) {
        selectedCatTrans.add(data);
      }
    });
  }

  piedata() async {
    final db = await Hive.openBox<TransactionModel>("TransactionDB2");
    incomecategories.clear();
    expensecategories.clear();
    List<String> incomecategorykey = db.keys
        .cast<String>()
        .where((key) => db.get(key)!.type == CategoryType.income)
        .toList();
    for (int i = 0; i < incomecategorykey.length; i++) {
      final TransactionModel? incomecatgry = db.get(incomecategorykey[i]);
      incomecategories.add(incomecatgry!.category.name);
      incomecategories.add(incomecatgry.amount);
    }
    List<String> expensecategorykey = db.keys
        .cast<String>()
        .where((key) => db.get(key)!.type == CategoryType.expense)
        .toList();
    for (int i = 0; i < expensecategorykey.length; i++) {
      final TransactionModel? expensecatgry = db.get(expensecategorykey[i]);
      expensecategories.add(expensecatgry!.category.name);
      expensecategories.add(expensecatgry.amount);
    }
    incomecatname.clear();
    incomeamt.clear();
    expensecatname.clear();
    expenseamt.clear();
    for (int i = 0; i < incomecategories.length; i++) {
      if (i % 2 == 0 || i == 0) {
        incomecatname.add(incomecategories[i]);
      } else {
        incomeamt.add(incomecategories[i]);
      }
    }

    for (int i = 0; i < expensecategories.length; i++) {
      if (i % 2 == 0 || i == 0) {
        expensecatname.add(expensecategories[i]);
      } else {
        expenseamt.add(expensecategories[i]);
      }
    }
    incallMap.clear();
    expallMap.clear();
    for (int i = 0; i < incomecatname.length; i++) {
      for (var j = i + 1; j < incomeamt.length; j++) {
        if (incomecatname[i] == incomecatname[j]) {
          incomeamt[i] = incomeamt[i] + incomeamt[j];
          incomeamt[j] = 0.0;
          incomecatname[j] = "";
        }
      }
      incomeamt.removeWhere((item) => item == 0.0);
      incomecatname.removeWhere((item) => item == "");
      incallMap.addAll({incomecatname[i]: incomeamt[i]});
    }
    for (int i = 0; i < expensecatname.length; i++) {
      for (var j = i + 1; j < expenseamt.length; j++) {
        if (expensecatname[i] == expensecatname[j]) {
          expenseamt[i] = expenseamt[i] + expenseamt[j];
          expenseamt[j] = 0.0;
          expensecatname[j] = "";
        }
      }
      expenseamt.removeWhere((item) => item == 0.0);
      expensecatname.removeWhere((item) => item == "");
      expallMap.addAll({expensecatname[i]: expenseamt[i]});
    }
    _homeController.totalBalaceCalculation(allTransactionList);
  }

  transactionDatabaseClear() async {
    final transDb = await Hive.openBox<TransactionModel>('TransactionDB2');
    await transDb.clear();
  }
}
