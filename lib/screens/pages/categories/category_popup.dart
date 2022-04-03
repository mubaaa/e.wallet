import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:money_managment/db/category_db/category_db.dart';
import 'package:money_managment/model/category/category_model.dart';
import 'package:money_managment/screens/pages/categories/category_page.dart';


ValueNotifier<CategoryType> selecetCategoryNotifier=ValueNotifier(CategoryType.income);
var _formKey = GlobalKey<FormState>();

Future<void> ShowPopupBox(BuildContext context) async{
  
  final _nameEditingController= TextEditingController();

  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          backgroundColor: Colors.black26,
          title:
              const Text("Add Category", style: TextStyle(color: Colors.white)),
          children: [
           const  SizedBox(height: 10,),
            Form(
              key: _formKey,
              child: Card(
                color: HexColor("20202B"),
                child: TextFormField(
                  controller: _nameEditingController,
                  textInputAction: TextInputAction.done,
                  cursorColor: Colors.grey,
                  style:const  TextStyle(color: Colors.white, fontSize: 20),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 20, bottom: 11, top: 11, right: 15),
                      label: Text(
                        "Item",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      )),
                       onFieldSubmitted: (value) {},
                      validator: (value) {
                      if (value!.isEmpty) {
                        return "Field is Required" ;
                      }
                      return null;
                    },
                ),
              ),
            ),

           const  SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: ElevatedButton(
                  style:
                      TextButton.styleFrom(backgroundColor: HexColor("43A79B")),
                  onPressed: () {
                      if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.of(context).pop();
                    }
                    final _name=_nameEditingController.text;
                   if (_name.isEmpty) {
                     return;
                   }
                   final CategoryType _type;
                   tabcontroller.index==0?_type=CategoryType.income:_type=CategoryType.expense;
                   final _category = CategoryModel(
                   id: DateTime.now().microsecondsSinceEpoch.toString(),
                   name: _name,
                   type: _type);
                   categoryDB.instance.insertCategory(_category);
                  //  Navigator.of(context).pop();
                  },
                    child: Container(
                    
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                              ),
                    ),
                  )),
          ],
        );
      });
}






































// class RadioButton extends StatelessWidget {
//   final title;
//   final type;
//   // final selecetedCategoryType;
//   const RadioButton({ Key? key, 
//  required this.title, 
//  required this.type, 
//   // this.selecetedCategoryType 
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//        children: [
//          ValueListenableBuilder(
//           valueListenable: selecetCategoryNotifier,
//           builder: (BuildContext ctx, CategoryType newCategory, Widget?_){
//             return Radio<CategoryType>(
//            value:type,
//             groupValue: selecetCategoryNotifier.value, 
//             onChanged: (value ){
//               if (value==null ) {
//                 return;
//               } 
//               selecetCategoryNotifier.value= value;
//               selecetCategoryNotifier.notifyListeners();
//             });
//           }),
//          Text(title)
//        ],
//     );
//   }
// }