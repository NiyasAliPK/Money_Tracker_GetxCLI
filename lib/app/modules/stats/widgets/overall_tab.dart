import 'package:flutter/material.dart';
import 'package:money_tracker_get_cli/app/data/controller/common_functions.dart';
import 'package:pie_chart/pie_chart.dart';

class OverallTab extends StatelessWidget {
  OverallTab({Key? key}) : super(key: key);
  final Map<String, double> dataMap = {
    'Income': CommonFunctions.instance.totalIncome,
    'Expense': CommonFunctions.instance.totalExpense
  };
  final Map<String, double> dataMapDummy = {'DummyInc': 1000, 'DummyExp': 500};
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
        ),
        Column(
          children: [
            PieChart(
              chartRadius: MediaQuery.of(context).size.width / 2.3,
              dataMap: dataMap.values.last == 0 && dataMap.values.first == 0
                  ? dataMapDummy
                  : dataMap,
            )
          ],
        ),
      ],
    );
  }
}
