import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/db/category_db.dart';
import 'package:money_manager/screens/screen_category/expence_tab.dart';
import 'package:money_manager/screens/screen_category/income_tab.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({Key? key}) : super(key: key);

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with TickerProviderStateMixin {
  late TabController _tabbarcontroller;
  @override
  void initState() {
    _tabbarcontroller = TabController(length: 2, vsync: this);
    CategoryDb().getCategories().then((value) {
      print('get from categories db');
      print(value.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabbarcontroller,
          tabs: [
            Tab(
              text: 'Income',
              icon: Icon(Icons.incomplete_circle),
            ),
            Tab(
              text: 'Expences',
              icon: Icon(Icons.ac_unit_sharp),
            )
          ],
        ),
        Expanded(
            child: TabBarView(
          children: [IncomeTab(), ExpenceTab()],
          controller: _tabbarcontroller,
        ))
      ],
    );
  }
}
