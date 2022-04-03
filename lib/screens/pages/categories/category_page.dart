import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:money_managment/db/category_db/category_db.dart';
import 'package:money_managment/screens/pages/categories/expence_category.dart';
import 'package:money_managment/screens/pages/categories/income_category.dart';

bool income = true;
bool expense = false;
late TabController tabcontroller;

class CategoryPage extends StatefulWidget {
  CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    tabcontroller = TabController(length: 2, vsync: this);
    categoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // bool income = true;
    // bool expense = false;
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Center(
            child: Text(
          "Categories",
          style: TextStyle(color: Colors.white, fontSize: 23),
        )),
        const SizedBox(
          height: 30,
        ),
        TabBar(
            indicator: BoxDecoration(
              color: HexColor("43A79B"),
            ),
            controller: tabcontroller,
            unselectedLabelColor: HexColor("43A79B"),
            tabs: const [
              Tab(
                text: "Income",
              ),
              Tab(
                text: "Expense",
              )
            ]),
        Expanded(
          child: TabBarView(controller: tabcontroller, children: const [
            IncomeCategory(),
            ExpneseCategory(),
          ]),
        )
      ],
    );
  }
}

class textButton extends StatelessWidget {
  final onpressed;
  final title;

  const textButton({Key? key, required this.onpressed, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onpressed,
      style: ButtonStyle(),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
