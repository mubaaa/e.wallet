import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:money_managment/db/transaction_db/transaction_db.dart';
import 'package:money_managment/model/transaction/transaction_model.dart';
import 'package:pie_chart/pie_chart.dart';


class IncomeShowChart extends StatefulWidget {
  const IncomeShowChart({Key? key}) : super(key: key);

  @override
  State<IncomeShowChart> createState() => _IncomeShowChartState();
}               

class _IncomeShowChartState extends State<IncomeShowChart> {
  
  @override
  Widget build(BuildContext context) {
   
    return Column(
      children: [
        PieChart(
          dataMap: ,
          chartRadius: MediaQuery.of(context).size.width / 1.4,
          legendOptions: const LegendOptions(
            legendPosition: LegendPosition.bottom,
            showLegendsInRow: true,
            legendTextStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          chartValuesOptions:
              const ChartValuesOptions(showChartValuesInPercentage: false),
        ),
        ValueListenableBuilder(
          valueListenable: TransactionDB.instance.incomeTransactionNotifier,
          builder: (ctx, List<TransactionModel> lists, _) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (cnt, index) {
                final keys = lists[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: HexColor("20202B"),
                  elevation: 0,
                  child: ListTile(
                      leading: Text(
                        keys.category.name,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      trailing: Wrap(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\u{20B9}${keys.amount}",
                                style: const TextStyle(color: Colors.green),
                              ),
                              Text(
                                parsedDate(keys.date),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      )),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: lists.length,
            );
          },
        ),
      ],
    );
  }

  String parsedDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year}";
  }
}
