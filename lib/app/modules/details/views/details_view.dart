import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:money_tracker_get_cli/app/data/models/transaction_model.dart';

import '../controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  final TransactionModel? data;

  DetailsView(this.data);

  SizedBox spacer = const SizedBox(
    height: 30,
  );
  SizedBox headSpacer = const SizedBox(
    height: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
              colors: [Color(0xFF6DD5ED), Color(0xFF2193B0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                spacer,
                const Text("Date",
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        fontSize: 17)),
                headSpacer,
                Text(data!.date
                    .toString()
                    .replaceRange(11, data!.date.toString().length, '')),
                spacer,
                const Text("Category",
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        fontSize: 17)),
                headSpacer,
                Text(data!.category.name),
                spacer,
                const Text("Amount",
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        fontSize: 17)),
                headSpacer,
                Text(data!.amount.toString()),
                spacer,
                const Text("Remark",
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        fontSize: 17)),
                headSpacer,
                Text(
                  data!.remarks,
                  style: const TextStyle(height: 1.7),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
