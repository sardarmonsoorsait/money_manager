import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/db/category_db.dart';
import 'package:money_manager/screens/home_screen/myhome.dart';

class HomeBottomNaviBar extends StatelessWidget {
  const HomeBottomNaviBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryDb.instance.updateUI();
    return ValueListenableBuilder(
        valueListenable: MyHome.indexNotifier,
        builder: (BuildContext context, int updatedIndex, Widget? _) {
          return BottomNavigationBar(
              currentIndex: updatedIndex,
              onTap: (value) {
                
                MyHome.indexNotifier.value = value;
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Transactions'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'Category')
              ]);
        });
  }
}
