import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_tracker_get_cli/app/data/models/category_model.dart';

class CategoryDatabase extends GetxController {
  RxList<CategoryModel> allCatsList = <CategoryModel>[].obs;
  RxList<CategoryModel> incomeCatsList = <CategoryModel>[].obs;
  RxList<CategoryModel> expenseCatsList = <CategoryModel>[].obs;

  addCategories(CategoryModel newCat) async {
    final catsDb = await Hive.openBox<CategoryModel>('TransactionDB');
    await catsDb.put(newCat.id, newCat);
    await refreshUi();
  }

  getAllCategories() async {
    final catsDb = await Hive.openBox<CategoryModel>('TransactionDB');
    allCatsList.clear();
    allCatsList.addAll(catsDb.values);
  }

  deleteSelectedCat(CategoryModel value) async {
    final catsDb = await Hive.openBox<CategoryModel>('TransactionDB');
    await catsDb.put(value.id, value);
  }

  Future<void> refreshUi() async {
    await getAllCategories();
    expenseCatsList.clear();
    incomeCatsList.clear();
    Future.forEach(allCatsList, (CategoryModel category) {
      if (category.type == CategoryType.income && category.isDeleted == false) {
        incomeCatsList.add(category);
      } else if (category.type == CategoryType.expense &&
          category.isDeleted == false) {
        expenseCatsList.add(category);
      }
    });
  }

  categoryDatabaseClear() async {
    final catsDb = await Hive.openBox<CategoryModel>('TransactionDB');
    await catsDb.clear();
  }
}
