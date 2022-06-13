import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/db/category_db.dart';
import 'package:money_manager/models/category_model/category_model.dart';

//import 'package:money_manager/lib/db/category_db.dart';
class ExpenceTab extends StatelessWidget {
  const ExpenceTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDb().expencelistnotifier,
        builder:
            (BuildContext context, List<CategoryModel> newlist, Widget? _) {
          return ListView.separated(
            itemBuilder: ((context, index) {
              final category = newlist[index];
              return Card(
                child: ListTile(
                  title: Text(category.name),
                  leading: Text('12/7/2022'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete_forever),
                    onPressed: () {
                      CategoryDb.instance.deleteCategory(category.id);
                    },
                  ),
                ),
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
