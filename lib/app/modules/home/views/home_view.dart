import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:money_tracker_get_cli/app/data/controller/transaction_db_controller.dart';
import 'package:money_tracker_get_cli/app/data/models/category_model.dart';
import 'package:money_tracker_get_cli/app/data/widgets/list_tiles_for_all.dart';
import 'package:money_tracker_get_cli/app/modules/home/widgets/amount_cards.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final HomeController _homeController = Get.put(HomeController());
  final TransactionDatabase tbController = Get.put(TransactionDatabase());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(
              height: 70,
            ),
            Text(
              'MONEY TRACKER',
              style: TextStyle(
                  fontFamily: 'ZenDots', fontSize: 30, color: Colors.white),
            ),
          ],
        ),
        Column(
          children: [
            AmountCards(
              cardWidth: 350,
              cardheight: 140,
              cardColor: const Color.fromARGB(255, 244, 247, 159),
              title: 'Total Balance',
              amount: _homeController.totalAmount,
              textSize: 25,
              titleColor: Colors.black,
              amountColor: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AmountCards(
                  cardWidth: 150,
                  cardheight: 100,
                  cardColor: const Color.fromARGB(255, 172, 250, 194),
                  title: 'Income',
                  amount: _homeController.totalIncome,
                  textSpacing: 15,
                  textSize: 20,
                  titleColor: const Color.fromARGB(255, 0, 165, 5),
                  amountColor: const Color.fromARGB(255, 0, 165, 5),
                ),
                AmountCards(
                  cardWidth: 150,
                  cardheight: 100,
                  cardColor: const Color.fromARGB(255, 245, 173, 173),
                  title: 'Expense',
                  amount: _homeController.totalExpense,
                  textSpacing: 15,
                  textSize: 20,
                  titleColor: const Color.fromARGB(255, 255, 17, 0),
                  amountColor: const Color.fromARGB(255, 255, 17, 0),
                )
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Recent Transactions'),
            TextButton.icon(
                style: TextButton.styleFrom(primary: Colors.black),
                onPressed: () {
                  Get.toNamed("/viewall");
                },
                icon: const Icon(
                  Icons.remove_red_eye,
                ),
                label: const Text('View All'))
          ],
        ),
        Expanded(
          child: Container(
              width: 350,
              height: 234,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                      colors: [Color(0xFF6DD5ED), Color(0xFF2193B0)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
              child: Obx(() {
                tbController.getAlltransactions();
                return tbController.allTransactionList.isEmpty
                    ? Center(
                        child: Lottie.asset(
                            'assets/animations/85023-no-data.json'),
                      )
                    : ListView.builder(
                        itemCount: tbController.allTransactionList.length < 5
                            ? tbController.allTransactionList.length
                            : 5,
                        itemBuilder: (BuildContext context, int index) {
                          final newList =
                              tbController.allTransactionList.reversed;
                          final data = newList.elementAt(index);
                          _homeController.totalBalaceCalculation(
                              tbController.allTransactionList);
                          return ListCards(
                            isViewAllPage: false,
                            textColor: data.type == CategoryType.income
                                ? Colors.green
                                : Colors.red,
                            data: data,
                          );
                        },
                      );
              })),
        )
      ],
    );
  }
}
