import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker_get_cli/app/data/controller/category_db_controller.dart';
import 'package:money_tracker_get_cli/app/data/models/category_model.dart';
import 'package:money_tracker_get_cli/app/data/models/transaction_model.dart';
import 'package:money_tracker_get_cli/app/data/widgets/text_fields.dart';
import 'package:money_tracker_get_cli/app/modules/edit/controllers/edit_controller.dart';
import 'package:money_tracker_get_cli/app/modules/navigation/views/navigation_view.dart';
import 'package:money_tracker_get_cli/app/modules/viewall/views/viewall_view.dart';

class EditView extends StatefulWidget {
  final TransactionModel? data;
  final bool? isViewAllPage;
  const EditView({Key? key, this.data, this.isViewAllPage}) : super(key: key);

  @override
  State<EditView> createState() => _EditViewsState();
}

class _EditViewsState extends State<EditView> {
  Object? selectedCatModelID;
  late CategoryModel selectedCategoryModel;
  final amountFromController = TextEditingController();
  final remarksFromController = TextEditingController();
  final CategoryDatabase _categoryDatabase = Get.put(CategoryDatabase());
  final EditController _editController = Get.put(EditController());

  @override
  void initState() {
    super.initState();
    amountFromController.text = widget.data!.amount.toString();
    remarksFromController.text = widget.data!.remarks;
    selectedCategoryModel = widget.data!.category;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF2193B0), Color(0xFF6DD5ED)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("Edit Transactions"),
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Container(
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
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GetBuilder<EditController>(builder: (eController) {
                        return TextButton.icon(
                          onPressed: () {
                            _editController.changeBoolState(true);
                            print("from page  ${_editController.dateChanged}");
                            _editController.datePicker(
                                context, widget.data!.date);
                          },
                          icon: const Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.white,
                          ),
                          label: Text(
                            eController.dateChanged == false
                                ? "${widget.data!.date.day}-${widget.data!.date.month}-${widget.data!.date.year}"
                                : "${eController.datePicked.day}-${eController.datePicked.month}-${eController.datePicked.year}",
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
                                  _categoryDatabase.refreshUi();
                                  _categoryDatabase.getAllCategories();
                                },
                              );
                              return DropdownButton(
                                  hint: Text(widget.data!.category.name),
                                  value: selectedCatModelID,
                                  items:
                                      widget.data!.type == CategoryType.expense
                                          ? _categoryDatabase.expenseCatsList
                                              .map((e) {
                                              return DropdownMenuItem<String>(
                                                onTap: () {
                                                  selectedCategoryModel = e;
                                                },
                                                child: Text(e.name),
                                                value: e.id,
                                              );
                                            }).toList()
                                          : _categoryDatabase.incomeCatsList
                                              .map((e) {
                                              return DropdownMenuItem<String>(
                                                onTap: () {
                                                  selectedCategoryModel = e;
                                                },
                                                child: Text(e.name),
                                                value: e.id,
                                              );
                                            }).toList(),
                                  onChanged: (selectedValue) {
                                    setState(() {
                                      selectedCatModelID = selectedValue;
                                    });
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
                          titleText: 'Remarks',
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
                                  onPressed: () async {
                                    await _editController.checkBeforeAdding(
                                        context,
                                        amountFromController.text,
                                        remarksFromController.text,
                                        widget.data,
                                        selectedCategoryModel);
                                    widget.isViewAllPage == true
                                        ? Get.off(() => ViewallView())
                                        : Get.offAll(() => NavigationView());
                                  },
                                  icon: const Icon(Icons.update),
                                  label: const Text('Update')),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
