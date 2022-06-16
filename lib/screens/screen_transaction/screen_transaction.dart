import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db/category_db.dart';
import 'package:money_manager/models/category_model/category_model.dart';
import 'package:money_manager/models/transaction_model/transaction_model.dart';

import '../../db/transaction_db.dart';

class ScreenTrasaction extends StatelessWidget {
  const ScreenTrasaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryDb.instance.updateUI;
    TransactionDB.instance.updatUI();
    return ValueListenableBuilder(
        valueListenable: TransactionDB.instance.modelNotifier,
        builder: (BuildContext ctx, List<TransactionModel> newlist, Widget? _) {
          return ListView.separated(
            itemBuilder: ((context, index) {
              final _list = newlist[index];
              return Slidable(
                key: Key(_list.id!),
                startActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context1) {
                        
                        TransactionDB.instance.deleteTransaction(_list.id.toString());
                      },
                      backgroundColor: Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                    SlidableAction(
                      onPressed: (context) {},
                      backgroundColor: Color(0xFF21B7CA),
                      foregroundColor: Colors.white,
                      icon: Icons.share,
                      label: 'share',
                    )
                  ],
                  /*dismissible: DismissiblePane(onDismissed: () {
                    TransactionDB.instance.deleteTransaction(_list.id!);
                  })*/
                ),
                child: Card(
                  shadowColor: _list.type == CategoryType.income
                      ? Color.fromARGB(255, 33, 107, 36)
                      : Color.fromARGB(255, 84, 8, 2),
                  child: ListTile(
                    title: Text('${_list.amount}'),
                    subtitle: Text('${_list.purpose}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        TransactionDB.instance.deleteTransaction(_list.id.toString());
                      },
                    ),
                    leading: CircleAvatar(
                      backgroundColor: _list.type == CategoryType.income
                          ? Color.fromARGB(255, 163, 231, 165)
                          : Color.fromARGB(255, 243, 148, 141),
                      child: Text(parsedate(_list.datetime)),
                    ),
                  ),
                ),
              );
            }),
            separatorBuilder: (context, index) {
              return SizedBox(height: 2);
            },
            itemCount: newlist.length,
          );
        });
  }

  String parsedate(DateTime date) {
    final format = DateFormat.MMMd();
    final _date = format.format(date);
    final splitdate = _date.split(' ');
    return '${splitdate.last}\n ${splitdate.first}';
    //return '${date.day}\n${date.month}';
  }
}
