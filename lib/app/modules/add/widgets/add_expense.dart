import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker_get_cli/app/data/controller/category_db_controller.dart';
import 'package:money_tracker_get_cli/app/data/controller/common_controller.dart';
import 'package:money_tracker_get_cli/app/data/controller/transaction_db_controller.dart';
import 'package:money_tracker_get_cli/app/data/models/category_model.dart';
import 'package:money_tracker_get_cli/app/data/widgets/text_fields.dart';
import 'package:money_tracker_get_cli/app/modules/add/controllers/add_controller.dart';

class AddExpense extends StatelessWidget {
  AddExpense({Key? key}) : super(key: key);

  final amountFromController = TextEditingController();
  final remarksFromController = TextEditingController();
  String hintText = 'Select Category';
  final ControllerGetX _controller = Get.put(ControllerGetX());

  @override
  Widget build(BuildContext context) {
    final TransactionDatabase transactionDatabase =
        Get.put(TransactionDatabase());
    final CategoryDatabase categoryController = Get.put(CategoryDatabase());
    final AddController addController = Get.put(AddController());
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(20, 80, 20, 0),
          width: 350,
          height: 350,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 161, 161, 161),
                    spreadRadius: 1,
                    blurStyle: BlurStyle.normal,
                    blurRadius: 20)
              ],
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                  colors: [Color(0xFF6DD5ED), Color(0xFF2193B0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder<AddController>(builder: (controller) {
                    return TextButton.icon(
                      onPressed: () {
                        controller.datePicker(context);
                      },
                      icon: const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.white,
                      ),
                      label: Text(
                        "${addController.datePicked.day}-${addController.datePicked.month}-${addController.datePicked.year}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  })
                ],
              ),
              Container(
                margin: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Category',
                          style: TextStyle(color: Colors.white),
                        ),
                        Flexible(child: Obx(() {
                          WidgetsBinding.instance.addPostFrameCallback(
                            (timeStamp) {
                              transactionDatabase.getAlltransactions();
                              categoryController.refreshUi();
                            },
                          );
                          return DropdownButton(
                              hint: Text(hintText),
                              value: addController.selectedCatModelID,
                              items:
                                  categoryController.expenseCatsList.map((e) {
                                return DropdownMenuItem<String>(
                                  onTap: () {
                                    addController.selectCatModel(e);
                                  },
                                  child: Text(e.name),
                                  value: e.id,
                                );
                              }).toList(),
                              onChanged: (selectedValue) {
                                addController.changeModelID(selectedValue);
                              });
                        }))
                      ],
                    ),
                    InputFields(
                        controller: amountFromController,
                        titleText: 'Amount',
                        isDense: false,
                        keyboardType: TextInputType.number),
                    const SizedBox(height: 15),
                    InputFields(
                      controller: remarksFromController,
                      titleText: 'Remark',
                      isDense: true,
                      keyboardType: TextInputType.text,
                      sizeForTextField: 30.0,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black),
                              onPressed: () {
                                addController.checkBeforeAdding(
                                    context,
                                    amountFromController.text,
                                    remarksFromController.text,
                                    CategoryType.expense);
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('Add')),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.black),
                onPressed: () async {
                  addController.oncClick(true);
                  await _controller.pickimage();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text(img.isEmpty ? "No image added" : "Image added"),
                    action: SnackBarAction(
                      label: 'Ok',
                      onPressed: () {},
                    ),
                  ));
                },
                child: const Text(
                  'Add Bill (optional)',
                )),
          ],
        )
      ],
    );
  }
}
