import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/models/category_model/category_model.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDbFunctions {
  Future<void> InsertCategory(CategoryModel value);
  Future<List<CategoryModel>> getCategories();
}

class CategoryDb implements CategoryDbFunctions {
  CategoryDb._internal();
  static CategoryDb instance =CategoryDb._internal();
  factory CategoryDb(){
    return instance;
  }



  ValueNotifier<List<CategoryModel>> incomelistnotifier = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expencelistnotifier = ValueNotifier([]);
  @override
  Future<void> InsertCategory(CategoryModel value) async {
    // TODO: implement InsertCategory
    final _categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDb.add(value);
    updateUI();
    //throw UnimplementedError();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDb.values.toList();
  }

  Future<void> updateUI() async {
    final _allcategoris = await getCategories();
    incomelistnotifier.value.clear();
    expencelistnotifier.value.clear();
    Future.forEach((_allcategoris), (CategoryModel category) {
      if (category.type == CategoryType.expence) {
        expencelistnotifier.value.add(category);
      } else {
        incomelistnotifier.value.add(category);
      }
    });
    incomelistnotifier.notifyListeners();
    expencelistnotifier.notifyListeners();
  }
}
