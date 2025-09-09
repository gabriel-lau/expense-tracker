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

  Future<void> loadExpenses() async {
    _isLoading = true;
    notifyListeners();
    try {
      _errorMessage = null;
      final loadedExpenses = await repository.getExpenses();
      _expenses.clear();
      _expenses.addAll(loadedExpenses);
      _expenses.sort((a, b) => b.date.compareTo(a.date));
    } catch (e) {
      _errorMessage = 'Failed to load expenses. Please check your connection.';
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
    // Optimistically add the expense
    _isLoading = true;
    Expense tempExpense = Expense(
      description: description,
      amount: amount,
      date: date,
    );
    _expenses.add(tempExpense);
    _expenses.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();

    try {
      // Create the expense in the backend
      _errorMessage = null;
      Expense createdExpense = await repository.createExpense(tempExpense);
      // Replace tempExpense with createdExpense (with backend id)
      int idx = _expenses.indexOf(tempExpense);
      _expenses[idx] = createdExpense;
      _expenses.sort((a, b) => b.date.compareTo(a.date));
    } catch (e) {
      // Revert the optimistic update if creation failed
      _errorMessage = 'Failed to add expense. Please check your connection.';
      _expenses.remove(tempExpense);
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
    // Optimistically update the expense
    _isLoading = true;
    final index = _expenses.indexWhere((e) => e.id == id);
    final oldExpense = _expenses[index];
    final updatedExpense = Expense(
      id: id,
      description: description,
      amount: amount,
      date: date,
    );
    _expenses[index] = updatedExpense;
    _expenses.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();

    try {
      // Update the expense in the backend
      _errorMessage = null;
      await repository.updateExpense(updatedExpense);
    } catch (e) {
      // Revert the optimistic update if update failed
      _errorMessage = 'Failed to edit expense. Please check your connection.';
      _expenses[index] = oldExpense;
      _expenses.sort((a, b) => b.date.compareTo(a.date));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteExpense(String id) async {
    // Optimistically remove the expense
    _isLoading = true;
    final index = _expenses.indexWhere((e) => e.id == id);
    Expense? removedExpense;
    removedExpense = _expenses.removeAt(index);
    notifyListeners();

    try {
      // Delete the expense in the backend
      _errorMessage = null;
      await repository.deleteExpense(id);
    } catch (e) {
      // Revert the optimistic update if deletion failed
      _errorMessage = 'Failed to delete expense. Please check your connection.';
      _expenses.insert(index, removedExpense);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
