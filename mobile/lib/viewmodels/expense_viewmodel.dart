import '../models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseViewModel extends ChangeNotifier {
  final List<Expense> _expenses = [
    Expense(
      id: '1',
      description: 'Groceries',
      amount: 50.0,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Expense(
      id: '2',
      description: 'Electricity Bill',
      amount: 75.5,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Expense(
      id: '3',
      description: 'Internet Subscription',
      amount: 30.0,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  List<Expense> get expenses => List.unmodifiable(_expenses);

  Future<void> loadExpenses() async {
    notifyListeners();
  }

  Future<void> addExpense(
    String description,
    double amount,
    DateTime date,
  ) async {
    final newExpense = Expense(
      id: DateTime.now().toIso8601String(),
      description: description,
      amount: amount,
      date: date,
    );

    _expenses.add(newExpense);
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
    _expenses[_expenses.indexWhere((e) => e.id == id)] = expense;
    notifyListeners();
  }

  Future<void> deleteExpense(String id) async {
    _expenses.removeWhere((e) => e.id == id);
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
