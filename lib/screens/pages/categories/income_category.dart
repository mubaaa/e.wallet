import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:money_managment/db/category_db/category_db.dart';
import 'package:money_managment/model/category/category_model.dart';
import 'package:money_managment/screens/pages/categories/category_popup.dart';

class IncomeCategory extends StatelessWidget {
  const IncomeCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Categories :",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                TextButton(
                    onPressed: () {
                      ShowPopupBox(context);
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: HexColor("43A79B")),
                    child: const Text(
                      "ADD",
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    ))
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ValueListenableBuilder(
                    valueListenable: categoryDB().incomeCategoryList,
                    builder: (BuildContext ctx, List<CategoryModel> newlist,
                        Widget? _) {
                      return ListView.separated(
                          physics: const ScrollPhysics(),
                          itemBuilder: (cnt, index) {
                            final category = newlist[index];
                            return Slidable(
                              key:Key(category.id) ,
                              startActionPane: ActionPane(
                                motion: const ScrollMotion(), 
                                children: [
                                  SlidableAction(
                                    onPressed: (ctx){
                                       categoryDB.instance
                                         .deleteCategory(category.id);
                                    },
                                    icon: Icons.delete,
                                    label: "Delete",
                                    backgroundColor: Colors.black,
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
                                   category.name,
                                   style : const TextStyle(
                                       color: Colors.white, fontSize: 20),
                                 ),
                              
                               ),
                                   ),
                            );
                          },
                          separatorBuilder: (ctx, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: newlist.length);
                  }))
          ],
        ),
      ),
    );
  }
}
