import 'package:expense_repository/src/models/category.dart';

abstract class ExpenseRepository {

  Future<void> createCategory(Category category);

  Future<List<Category>> getCategory();
}