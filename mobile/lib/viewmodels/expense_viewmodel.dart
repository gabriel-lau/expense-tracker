import 'package:expense_tracker/repositories/expense_repository.dart';
import '../models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseViewModel extends ChangeNotifier {
  final ExpenseRepository repository;
  ExpenseViewModel({required this.repository});
  final List<Expense> _expenses = [];
  String? errorMessage;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Expense> get expenses => List.unmodifiable(_expenses);

  Future<void> loadExpenses() async {
    _isLoading = true;
    notifyListeners();
    try {
      errorMessage = null;
      final loadedExpenses = await repository.getExpenses();
      _expenses.clear();
      _expenses.addAll(loadedExpenses);
      _expenses.sort((a, b) => b.date.compareTo(a.date));
    } catch (e) {
      errorMessage = 'Failed to load expenses. Please check your connection.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addExpense(
    String description,
    double amount,
    DateTime date,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      errorMessage = null;
      final newExpense = Expense(
        description: description,
        amount: amount,
        date: date,
      );
      await repository.createExpense(newExpense);
      await loadExpenses();
    } catch (e) {
      errorMessage = 'Failed to add expense. Please check your connection.';
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> editExpense(
    String id,
    String description,
    double amount,
    DateTime date,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      errorMessage = null;
      final expense = Expense(
        id: id,
        description: description,
        amount: amount,
        date: date,
      );
      await repository.updateExpense(expense);
      await loadExpenses();
    } catch (e) {
      errorMessage = 'Failed to edit expense. Please check your connection.';
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteExpense(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      errorMessage = null;
      await repository.deleteExpense(id);
      await loadExpenses();
    } catch (e) {
      errorMessage = 'Failed to delete expense. Please check your connection.';
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Expense? getExpenseById(String id) {
    try {
      return _expenses.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }
}
