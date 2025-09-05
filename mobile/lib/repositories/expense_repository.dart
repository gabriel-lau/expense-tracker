import '../models/expense.dart';

// In Dart every class defines an implicit interface
abstract class ExpenseRepository {
  Future<List<Expense>> getExpenses();
  Future<Expense> createExpense(Expense expense);
  Future<void> updateExpense(Expense expense);
  Future<void> deleteExpense(String id);
}
