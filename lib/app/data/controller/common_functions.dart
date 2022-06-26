import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CommonFunctions extends GetxController {
  double totalExpense = 0;
  double totalIncome = 0;

  CommonFunctions.internal();
  static CommonFunctions instance = CommonFunctions.internal();
  factory CommonFunctions() {
    return instance;
  }

  successSnackBar(dynamic context) {
    showTopSnackBar(
      context,
      const CustomSnackBar.success(
        message: "Transaction Added Successfully",
      ),
    );
  }

  failedSnackBar(dynamic context, String text) {
    showTopSnackBar(
      context,
      CustomSnackBar.error(
        message: text,
      ),
    );
  }

  infoSnackBar(dynamic context) {
    showTopSnackBar(
      context,
      const CustomSnackBar.info(
        message: "There is no bill image added",
      ),
    );
  }
}
