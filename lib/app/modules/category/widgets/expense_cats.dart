import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:money_tracker_get_cli/app/data/controller/category_db_controller.dart';
import 'package:money_tracker_get_cli/app/data/controller/transaction_db_controller.dart';
import 'package:money_tracker_get_cli/app/data/models/category_model.dart';
import 'package:money_tracker_get_cli/app/data/widgets/list_tiles_for_all.dart';
import 'package:money_tracker_get_cli/app/modules/category/controllers/category_controller.dart';

// ignore: must_be_immutable
class ExpenseCats extends StatelessWidget {
  ExpenseCats({Key? key}) : super(key: key);

  String catsOfExpense = 'Category';
  final CategoryDatabase _categoryController = Get.put(CategoryDatabase());
  final TransactionDatabase _transactionDatabase =
      Get.put(TransactionDatabase());
  final CategoryController _controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        SizedBox(
            height: 180,
            child: Obx(() {
              WidgetsBinding.instance.addPostFrameCallback(
                (timeStamp) {
                  _categoryController.getAllCategories();
                  _categoryController.refreshUi();
                },
              );
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 50,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 50),
                itemCount: _categoryController.expenseCatsList.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = _categoryController.expenseCatsList[index];
                  final catName = data.name;
                  return ElevatedButton(
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Delete Categories'),
                                content: const Text(
                                    'Do you want to delete this category ? If deleted this category will not be shown in Diagrams.',
                                    style: TextStyle(height: 2)),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        final temp = CategoryModel(
                                            id: data.id,
                                            name: data.name,
                                            type: data.type,
                                            isDeleted: true);
                                        await _categoryController
                                            .deleteSelectedCat(temp);
                                        Get.back();
                                      },
                                      child: const Text('Yes')),
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text('No'))
                                ],
                              );
                            });
                      },
                      style: ElevatedButton.styleFrom(
                          primary: _controller.isCatSelected == index
                              ? Colors.black
                              : const Color.fromARGB(255, 245, 79, 67)),
                      onPressed: () {
                        _controller.changeState(index, true);
                        final selectedCatName = data.name;
                        _transactionDatabase.sortForSelectedCat(
                            selectedCatName, 1);
                      },
                      child: Text(catName));
                },
              );
            })),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        colors: [Color(0xFF6DD5ED), Color(0xFF2193B0)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight)),
                child: Obx(() {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    _transactionDatabase.getAlltransactions();
                    _transactionDatabase.refreshUiForTransaction();
                  });
                  return (_transactionDatabase.expenseTransactionList.isEmpty ||
                          _transactionDatabase.selectedCatTrans.isEmpty)
                      ? Center(
                          child: Lottie.asset(
                              'assets/animations/85023-no-data.json'),
                        )
                      : ListView.builder(
                          itemCount: _controller.isbuttonPressed == false
                              ? _transactionDatabase
                                  .expenseTransactionList.length
                              : _transactionDatabase.selectedCatTrans.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = _controller.isbuttonPressed == false
                                ? _transactionDatabase
                                    .expenseTransactionList[index]
                                : _transactionDatabase.selectedCatTrans[index];

                            return ListCards(
                              isViewAllPage: false,
                              textColor: Colors.red,
                              data: data,
                            );
                          },
                        );
                })),
          ),
        )
      ],
    );
  }
}
