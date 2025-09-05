import '../models/expense.dart';
import '../data/expense_api_data_source.dart';
import 'expense_repository.dart';

class ExpenseRepositoryApiImpl implements ExpenseRepository {
  final ExpenseApiDataSource dataSource;

  ExpenseRepositoryApiImpl(this.dataSource);

  @override
  Future<List<Expense>> getExpenses() => dataSource.fetchExpenses();

  @override
  Future<Expense> createExpense(Expense expense) =>
      dataSource.createExpense(expense);

  @override
  Future<Expense> updateExpense(Expense expense) =>
      dataSource.updateExpense(expense);

  @override
  Future<void> deleteExpense(String id) => dataSource.deleteExpense(id);
}
