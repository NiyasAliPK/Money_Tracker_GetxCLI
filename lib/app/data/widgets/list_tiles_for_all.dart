import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker_get_cli/app/data/controller/common_functions.dart';
import 'package:money_tracker_get_cli/app/data/controller/transaction_db_controller.dart';
import 'package:money_tracker_get_cli/app/data/models/transaction_model.dart';
import 'package:money_tracker_get_cli/app/modules/billimage/views/billimage_view.dart';
import 'package:money_tracker_get_cli/app/modules/details/views/details_view.dart';
import 'package:money_tracker_get_cli/app/modules/edit/views/edit_view.dart';
import 'package:money_tracker_get_cli/app/modules/home/controllers/home_controller.dart';

class ListCards extends StatelessWidget {
  final Color? textColor;
  final TransactionModel data;
  final bool isViewAllPage;
  final String selectedPeriod;
  final int selectedPageIndex;
  const ListCards(
      {Key? key,
      required this.isViewAllPage,
      this.textColor,
      required this.data,
      this.selectedPageIndex = 0,
      this.selectedPeriod = "All"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TransactionDatabase tbController = Get.put(TransactionDatabase());
    final HomeController homeController = Get.put(HomeController());
    final CommonFunctions comController = Get.put(CommonFunctions());
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
      child: Slidable(
        actionPane: const SlidableDrawerActionPane(),
        actions: [
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete'),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              await tbController
                                  .deleteSelectedTransaction(data.id);
                              await tbController.piedata();
                              await tbController.sortorPeriod(
                                  selectedPeriod: selectedPeriod,
                                  selectedPageIndex: selectedPageIndex);
                              isViewAllPage == true ? null : Get.back();
                              await homeController.totalBalaceCalculation(
                                  tbController.allTransactionList);
                              if (isViewAllPage == true) {
                                Get.back();
                              } else if (isViewAllPage == false) {
                                Get.offAllNamed("/navigation");
                              }
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
          ),
          IconSlideAction(
            caption: 'Edit',
            color: Colors.green,
            icon: Icons.edit,
            onTap: () {
              Get.to(() => EditView(data: data, isViewAllPage: isViewAllPage));
            },
          )
        ],
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            onLongPress: (() {
              if (data.image == null || data.image.toString().trim().isEmpty) {
                comController.infoSnackBar(context);
              } else {
                Get.to(() => BillimageView(image: data.image!));
              }
            }),
            onTap: (() => Get.to(() => DetailsView(
                  data,
                ))),
            textColor: textColor,
            leading: CircleAvatar(
                radius: 30,
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      parseDate(data.date),
                      style: const TextStyle(fontSize: 14),
                    ),
                    data.image == null || data.image.toString().trim().isEmpty
                        ? Container()
                        : const Icon(
                            Icons.image,
                            size: 20,
                          ),
                  ],
                )),
            title: AutoSizeText(
              '${data.amount}',
              style: const TextStyle(fontSize: 17),
              minFontSize: 12,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: AutoSizeText(
              data.remarks,
              style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Releway',
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              minFontSize: 12,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: AutoSizeText(
              data.category.name,
              style: const TextStyle(
                  fontSize: 17,
                  fontFamily: 'Releway',
                  fontWeight: FontWeight.w900),
              minFontSize: 7,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  String parseDate(DateTime date) {
    return DateFormat("dd\nMMM").format(date);
  }
}
