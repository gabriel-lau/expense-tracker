import 'package:expense_tracker/repositories/expense_repository.dart';
import '../models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseViewModel extends ChangeNotifier {
  final ExpenseRepository repository;
  ExpenseViewModel({required this.repository});

  final List<Expense> _expenses = [];
  String? _errorMessage;
  bool _isLoading = false;

  List<Expense> get expenses => List.unmodifiable(_expenses);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> _refreshExpenses() async {
    final loadedExpenses = await repository.getExpenses();
    _expenses.clear();
    _expenses.addAll(loadedExpenses);
    _expenses.sort((a, b) => b.date.compareTo(a.date));
  }

  Future<void> loadExpenses() async {
    _isLoading = true;
    notifyListeners();
    try {
      _errorMessage = null;
      await _refreshExpenses();
    } catch (e) {
      _errorMessage = 'Failed to load expenses. Please check your connection.';
    } finally {
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> addExpense(
    String description,
    double amount,
    DateTime date,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      _errorMessage = null;
      final newExpense = Expense(
        description: description,
        amount: amount,
        date: date,
      );
      // _expenses.add(newExpense);
      await repository.createExpense(newExpense);
      await _refreshExpenses();
    } catch (e) {
      _errorMessage = 'Failed to add expense. Please check your connection.';
    } finally {
      _isLoading = false;
    }
    notifyListeners();
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
      _errorMessage = null;
      final expense = Expense(
        id: id,
        description: description,
        amount: amount,
        date: date,
      );
      // final index = _expenses.indexWhere((e) => e.id == id);
      // if (index != -1) {
      //   _expenses[index] = expense;
      // }
      await repository.updateExpense(expense);
      await _refreshExpenses();
    } catch (e) {
      _errorMessage = 'Failed to edit expense. Please check your connection.';
    } finally {
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> deleteExpense(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      _errorMessage = null;
      // _expenses.removeWhere((e) => e.id == id);
      await repository.deleteExpense(id);
      await _refreshExpenses();
    } catch (e) {
      _errorMessage = 'Failed to delete expense. Please check your connection.';
    } finally {
      _isLoading = false;
    }
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
