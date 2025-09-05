import 'package:expense_tracker/repositories/expense_repository.dart';
import '../models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseViewModel extends ChangeNotifier {
  final ExpenseRepository repository;
  ExpenseViewModel({required this.repository});
  final List<Expense> _expenses = [];

  List<Expense> get expenses => List.unmodifiable(_expenses);

  Future<void> loadExpenses() async {
    await repository.getExpenses().then((loadedExpenses) {
      _expenses.clear();
      _expenses.addAll(loadedExpenses);
      _expenses.sort((a, b) => b.date.compareTo(a.date));
      notifyListeners();
    });
  }

  Future<void> addExpense(
    String description,
    double amount,
    DateTime date,
  ) async {
    final newExpense = Expense(
      description: description,
      amount: amount,
      date: date,
    );
    await repository.createExpense(newExpense);
    await loadExpenses();
    notifyListeners();
  }

  Future<void> editExpense(
    String id,
    String description,
    double amount,
    DateTime date,
  ) async {
    final expense = Expense(
      id: id,
      description: description,
      amount: amount,
      date: date,
    );
    await repository.updateExpense(expense);
    await loadExpenses();
    notifyListeners();
  }

  Future<void> deleteExpense(String id) async {
    await repository.deleteExpense(id);
    await loadExpenses();
    notifyListeners();
  }

  Expense? getExpenseById(String id) {
    try {
      return _expenses.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }
}
