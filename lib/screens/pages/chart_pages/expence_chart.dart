import 'package:flutter/MAterial.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:money_managment/db/transaction_db/transaction_db.dart';
import 'package:money_managment/model/transaction/transaction_model.dart';
import 'package:pie_chart/pie_chart.dart';

class ExpenceChart extends StatefulWidget {
  ExpenceChart({Key? key}) : super(key: key);

  @override
  State<ExpenceChart> createState() => _ExpenceChartState();
}

class _ExpenceChartState extends State<ExpenceChart> {
  Map<String, double> dataMap = {
    "Food": 2,
    "Travel": 4,
    "Medcine": 3,
    "salary": 2,
  
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PieChart(
            dataMap: dataMap,
            chartRadius: MediaQuery.of(context).size.width / 1.7,
            legendOptions: const LegendOptions(
              legendPosition: LegendPosition.bottom,
              showLegendsInRow: true,
              legendTextStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            chartValuesOptions:
                const ChartValuesOptions(showChartValuesInPercentage: true),
          ),
          ValueListenableBuilder(
            valueListenable:TransactionDB.instance.expenseTransactionNotifier,
            builder: (ctx,List<TransactionModel>lists,_){
              return  ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (cnt, index) {
                  final keys=lists[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: HexColor("20202B"),
                    elevation: 0,
                    child: ListTile(
                        leading:   Text(
                           keys.category.name,
                          style:const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        trailing: Wrap(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children:  [
                                  Text("\u{20B9}${keys.amount}",style:const TextStyle(color: Colors.red),),
                                  Text(
                                   parsedDate(keys.date),
                                    style:const TextStyle(color: Colors.white),
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
                itemCount: lists.length,);
            },
            
          ),
        ],
      ),
    );
  }

  String parsedDate(DateTime date){
    return "${date.day}-${date.month}-${date.year}";
}
}