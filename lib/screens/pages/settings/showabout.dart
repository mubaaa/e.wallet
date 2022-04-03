
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:money_managment/costant_widget/basic_wigdet.dart';

Future<void> showAboutPopup(BuildContext context)async {
      showDialog(context: context , 
      builder: (ctx){
        return  Padding(
          padding: const  EdgeInsets.all(20),
          child: SimpleDialog(
            backgroundColor: Colors.grey,
             title:
              const  Center(child:  Text("E.Wallet", style: TextStyle(color: Colors.white,fontSize: 25))),
               children: [
              const  Padding(
                 padding: EdgeInsets.all(20),
                 child: Text("This is a offline Income , Expense tracker app developed by Mubashira.A under the BrotoType acadamy",style: TextStyle(color: Colors.white,fontSize: 20),),
               ),
               sized15,
                  SizedBox(
                    width: 20,
                 child: TextButton(
                   onPressed: (){
                   Navigator.pop(context);
                 }, child:  Text("cancel",style: TextStyle(color: HexColor("43A79B")),)),
               ),
             ],
          ),
        );
      });
}