import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/db/category_db.dart';
import 'package:money_manager/db/transaction_db.dart';
import 'package:money_manager/models/category_model/category_model.dart';
import 'package:money_manager/screens/home_screen/widgets/navigation_bar.dart';
import 'package:money_manager/screens/screen_category/category_page.dart';
import 'package:money_manager/screens/screen_category/category_popup.dart';
import 'package:money_manager/screens/screen_transaction/add_transaction_screen/add_transaction_screen.dart';
import 'package:money_manager/screens/screen_transaction/screen_transaction.dart';
//import 'package:money_manager/screens/screen_home/screen_home.dart';

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);
  final _pages = const [ScreenTrasaction(), ScreenCategory()];
  static ValueNotifier<int> indexNotifier = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    
    TransactionDB.instance.updatUI;
    return Scaffold(
      bottomNavigationBar:const HomeBottomNaviBar(),
      appBar: AppBar(
        title:const Text('MONEYMANAGER'),
      ),
      body: ValueListenableBuilder(
          valueListenable: indexNotifier,
          builder: (BuildContext context, int index, _) {
            
            return SafeArea(
              child: _pages[index],
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (indexNotifier.value == 0) {
              //print('this is from transaction page');
              Navigator.of(context).pushNamed(AddTransactionScreen.routeName);
              CategoryDb.instance.updateUI();
            } else {
              // print('this is from category page');
              // final _sample = CategoryModel(id: DateTime.now().millisecondsSinceEpoch.toString(), name: 'Travel', type:CategoryType.expence);
              // CategoryDb().InsertCategory(_sample);
              CategoryPopup(context);
              CategoryDb.instance.updateUI();
            }
          },
          child: Icon(Icons.add)),
    );
  }
}
