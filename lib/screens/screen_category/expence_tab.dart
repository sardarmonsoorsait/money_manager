import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ExpenceTab extends StatelessWidget {
  const ExpenceTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: ((context, index) {
        return Card(
          child: ListTile(
            title: Text('Expences'),
            leading: Text('12/7/2022'),
            trailing: Icon(Icons.delete_forever),
          ),
        );
      }),
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 2,
        );
      },
      itemCount: 20,
    );
  }
}
