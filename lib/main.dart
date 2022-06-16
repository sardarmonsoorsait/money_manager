import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/models/category_model/category_model.dart';
import 'package:money_manager/models/transaction_model/transaction_model.dart';
import 'package:money_manager/screens/home_screen/myhome.dart';
import 'package:money_manager/screens/screen_transaction/add_transaction_screen/add_transaction_screen.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if(!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)){
    Hive.registerAdapter(TransactionModelAdapter());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.cyan),
      home:const MyHome(),
      routes: {
        AddTransactionScreen.routeName: (ctx) =>  AddTransactionScreen()
      },
    );
  }
}
