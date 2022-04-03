import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:money_managment/costant_widget/Basic_wigdet.dart';
import 'package:money_managment/db/transaction_db/transaction_db.dart';
import 'package:money_managment/model/category/category_model.dart';
import 'package:money_managment/model/transaction/transaction_model.dart';
import 'package:money_managment/screens/pages/newhome/widget.dart';
import 'package:pie_chart/pie_chart.dart';

class OverviewChart extends StatelessWidget {


  OverviewChart({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context ) {
      Map<String, double> dataMap = {

    "Income": incomeNotifier.value,
    "Expnse": expenseNotifier.value
  };

    return SingleChildScrollView(
      child: Column(
        children: [
          sized15,
          PieChart(
            dataMap: dataMap,
            animationDuration: const Duration(milliseconds: 1000),
            ringStrokeWidth: 43,
            chartRadius: MediaQuery.of(context).size.width / 1.7,
            chartType: ChartType.ring,
            legendOptions: const LegendOptions(
              legendPosition: LegendPosition.bottom,
              showLegendsInRow: true,
              legendTextStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            chartValuesOptions: const ChartValuesOptions(
                 showChartValuesInPercentage: false,
                showChartValueBackground: true,
                showChartValues: true,
                showChartValuesOutside: true),
          ),
          ValueListenableBuilder(
            valueListenable: TransactionDB.instance.TransactionNotifier,
            builder: (ctx, List<TransactionModel> NewList, _) {
              return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (cnt, index) {
                    final key = NewList[index];
                    return Slidable(
                      key: Key(key.id!),
                      startActionPane:
                          ActionPane(motion: const ScrollMotion(), children: [
                        SlidableAction(
                          onPressed: (ctx) {
                            TransactionDB.instance.deleteTransaction(key.id!);
                          },
                          icon: Icons.delete,
                          backgroundColor: Colors.black,
                          label: "Delete",
                          foregroundColor: Colors.redAccent,
                        )
                      ]),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: HexColor("20202B"),
                        elevation: 0,
                        child: ListTile(
                            leading: Text(
                              key.category.name,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            trailing: Wrap(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "\u{20B9}${key.amount}",
                                      style: TextStyle(
                                          color: key.type == CategoryType.income
                                              ? Colors.green
                                              : Colors.red),
                                    ),
                                    Text(
                                      parsedDate(key.date),
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: NewList.length);
            },
          ),
        ],
      ),
    );
  }

  String parsedDate(DateTime date) {
    final _date=DateFormat.MMMd().format(date);
    final _splittedDate=_date.split("");
    return "${_splittedDate.last}-${_splittedDate.first}-${date.year}";
     // return '${date.day}\n${date.month}';
  }
}
