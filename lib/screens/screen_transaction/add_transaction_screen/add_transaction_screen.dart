import 'package:flutter/material.dart';
import 'package:money_manager/db/category_db.dart';
import 'package:money_manager/db/transaction_db.dart';
import 'package:money_manager/models/category_model/category_model.dart';
import 'package:money_manager/models/transaction_model/transaction_model.dart';

//const INTIALVALUE = 'string';

class AddTransactionScreen extends StatefulWidget {
  AddTransactionScreen({Key? key}) : super(key: key);
  static const routeName = 'add-transaction';
  //ValueNotifier<TrasactionModel> modelNotifier = ValueNotifier(value);
  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

/*purpose
  amount
  date
  categorytype
  item */
class _AddTransactionScreenState extends State<AddTransactionScreen> {
  DateTime? _selecteddate;
  CategoryType? _selectedcategorytype;
  CategoryModel? _selectedcategorymodel;
  String? _selectedvalue;
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _amountcontroller = TextEditingController();
  @override
  void initState() {
    _selectedcategorytype = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          TextFormField(
            controller: _namecontroller,
          ),
          TextFormField(
            controller: _amountcontroller,
          ),
          TextButton.icon(
            onPressed: () async {
              final selected_datetemp = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(Duration(days: 30)),
                lastDate: DateTime.now(),
              );
              setState(() {
                _selecteddate = selected_datetemp;
              });
            },
            label: Text(
              _selecteddate == null ? 'Select Date' : _selecteddate.toString(),
            ),
            icon: Icon(Icons.calendar_today),
          ),
          Row(
            children: [
              Row(
                children: [
                  Radio(
                      value: CategoryType.income,
                      groupValue: _selectedcategorytype,
                      onChanged: (type) {
                        setState(() {
                          _selectedcategorytype = CategoryType.income;
                          _selectedvalue = null;
                        });
                      }),
                  const Text("Income")
                ],
              ),
              Row(
                children: [
                  Radio(
                      value: CategoryType.expence,
                      groupValue: _selectedcategorytype,
                      onChanged: (type) {
                        setState(() {
                          _selectedcategorytype = CategoryType.expence;
                          _selectedvalue = null;
                        });
                      }),
                  const Text('Expence')
                ],
              ),
            ],
          ),
          DropdownButton(
            hint: const Text('select the category'),
            value: _selectedvalue,
            items: (_selectedcategorytype == CategoryType.income
                    ? CategoryDb().incomelistnotifier.value
                    : CategoryDb().expencelistnotifier.value)
                .map((e) {
              return DropdownMenuItem(
                value: e.id,
                child: Text(e.name),
                onTap: () {
                  _selectedcategorymodel = e;
                },
              );
            }).toList(),
            onChanged: (newValue) {
              print(newValue);
              setState(() {
                _selectedvalue = newValue.toString();
                //newValue = null;
              });
            },
          ),
          ElevatedButton(
              onPressed: () {
                insTransaction();
                Navigator.of(context).pop();
              },
              child: const Text('Submit')),
        ],
      )),
    );
  }

  Future<void> insTransaction() async {
    final _purpose = _namecontroller.text;
    if (_purpose.isEmpty) {
      return;
    }
    final _amount = _amountcontroller.text;
    if (_amount.isEmpty) {
      return;
    }
    final parsedamount = double.tryParse(_amount);
    if (parsedamount == null) {
      return;
    }
    final date = _selecteddate;
    if (date == null) {
      return;
    }
    final CategoryType _type = _selectedcategorytype!;
    final CategoryModel categorymodel = _selectedcategorymodel!;

    // final _model = TransactionModel(
    //   purpose: purpose,

    //   amount: amount,
    //   datetime: date,
    //   type: _type,
    //   categorymodel: categorymodel,
    // );

    final _model = TransactionModel(
        purpose: _purpose,
        amount: parsedamount,
        datetime: date,
        type: _type,
        categorymodel: categorymodel);

    TransactionDB.instance.insertTransaction(_model);
    TransactionDB.instance.updatUI();
  }
}
