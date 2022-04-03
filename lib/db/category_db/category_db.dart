
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:money_managment/model/category/category_model.dart';
import 'package:hive_flutter/hive_flutter.dart';


const CATEGORY_DB_NAME ='category-database';

abstract class CategoryDbFunction{
 Future<List<CategoryModel>> getCategories();
 Future <void> insertCategory(CategoryModel value);
 Future <void> deleteCategory(String categoryID)async{
 }
}

class categoryDB implements CategoryDbFunction{
  categoryDB._internal();//named constrctor
   static categoryDB instance=categoryDB._internal();
   factory categoryDB(){// to ensure create a obj
     return instance;
   }

 ValueNotifier<List<CategoryModel>> incomeCategoryList=ValueNotifier([]);
 ValueNotifier<List<CategoryModel>> expenseCategoryList=ValueNotifier([]);

 @override
  Future<void> insertCategory(CategoryModel value) async{
     final _categoryDB =await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.put(value.id,value);
    refreshUI(); 
  }


  @override
  Future<List<CategoryModel>> getCategories() async{
   final _categoryDB =await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList(); 
  }


  Future <void> refreshUI() async {
     final _allCategories= await getCategories();
     incomeCategoryList.value.clear();
     expenseCategoryList.value.clear();
    await Future.forEach(
      _allCategories, 
      (CategoryModel category){
         if (category.type==CategoryType.income) {
           incomeCategoryList.value.add(category);  
         } else {
           expenseCategoryList.value.add(category);
         }
     }
     );

    
   incomeCategoryList.notifyListeners();
   expenseCategoryList.notifyListeners();
 }

  @override
  Future<void> deleteCategory(String categoryID) async{
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.delete(categoryID);
    refreshUI();
  } 
} 