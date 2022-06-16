import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:money_manager/db/category_db.dart';
import 'package:money_manager/models/category_model/category_model.dart';

ValueNotifier<CategoryType> typeNotifier = ValueNotifier(CategoryType.income);
final TextEditingController _textConroller = TextEditingController();
Future<void> CategoryPopup(BuildContext context) async {
 await showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: Text("Category"),
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _textConroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'category name'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: [
                  RadioButton(
                    title: 'expence',
                    type: CategoryType.expence,
                  ),
                  RadioButton(
                    title: 'income',
                    type: CategoryType.income,
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  final String _text;
                  _text = _textConroller.text;
                  final _type = typeNotifier.value;
                  CategoryModel _category = CategoryModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: _text,
                      type: _type);
                  CategoryDb().InsertCategory(_category);
                  Navigator.of(ctx).pop();
                },
                child: Text('Add'))
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  //final CategoryType _type;
  const RadioButton({required this.title, required this.type, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: typeNotifier,
            builder: (BuildContext context, CategoryType newtype, Widget? _) {
              return Radio<CategoryType>(
                  value: type,
                  groupValue: newtype,
                  onChanged: (newvalue) {
                    if (newvalue == null) {
                      return;
                    }
                    typeNotifier.value = newvalue;
                    typeNotifier.notifyListeners();
                  });
            }),
        Text(title)
      ],
    );
  }
}
