import 'package:expense_tracker/repositories/expense_repository.dart';
import '../models/expense.dart';
import 'package:flutter/material.dart';

// PRESENTATION LAYER - ViewModel with ChangeNotifier, Notify listeners (UI) on data change
class ExpenseViewModel extends ChangeNotifier {
  final ExpenseRepository repository;
  ExpenseViewModel({required this.repository});

  // Private
  final List<Expense> _expenses = [];
  String? _errorMessage;
  bool _isLoading = false;

  // Public - Unmodifiable view of the expenses list, loading state, and error message
  List<Expense> get expenses => List.unmodifiable(_expenses);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Triggered when the ExpenseListPage is first created and when the user pulls to refresh
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

  // Triggered in AddEditExpensePage when the user adds an expense.
  // Optimistic UI updates for add
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

  // Triggered in AddEditExpensePage when the user edits an expense.
  // Optimistic UI updates for edit
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

  // Triggered in ExpenseListPage when the user swipes to delete an expense.
  // Optimistic UI updates for delete
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
