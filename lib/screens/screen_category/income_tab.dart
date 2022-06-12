import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/db/category_db.dart';
import 'package:money_manager/models/category_model/category_model.dart';

class IncomeTab extends StatelessWidget {
  const IncomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDb().incomelistnotifier,
        builder: (BuildContext context, List<CategoryModel> newlist, _) {
          return ListView.separated(
            itemBuilder: ((context, index) {
              final category = newlist[index];
              return Card(
                child: ListTile(
                    title: Text(category.name),
                    leading: Text('12/7/2022'),
                    trailing: Icon(Icons.delete_forever)),
              );
            }),
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 2,
              );
            },
            itemCount: newlist.length,
          );
        });
  }
}
