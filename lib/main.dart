import 'package:flutter/material.dart';
import 'package:money_managment/model/category/category_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_managment/model/transaction/transaction_model.dart';
import 'package:money_managment/screens/Transaction_add/screen_transaction.dart';
import 'package:money_managment/screens/spalsh_Screen/splash_screen.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

 if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
     Hive.registerAdapter(TransactionModelAdapter());
 }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(backgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: const SplashScreenhome(),
      routes: {TransactionScreen.routName: (ctx) => TransactionScreen()},
    );
  }
}
