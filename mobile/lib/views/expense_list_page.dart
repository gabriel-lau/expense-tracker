import 'package:expense_tracker/views/add_edit_expense_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart'; // Provider with ChangeNotifier - Automatic rebuilds of UI on data change so we don't have to use setState
import '../viewmodels/expense_viewmodel.dart';

class ExpenseListPage extends StatelessWidget {
  const ExpenseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ExpenseViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Expenses')),
      body: RefreshIndicator(
        onRefresh: () async {
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        child: ListView.builder(
          itemCount: vm.expenses.length,
          itemBuilder: (context, index) {
            final expense = vm.expenses[index];
            return Dismissible(
              key: Key(expense.id),
              onDismissed: (direction) => vm.deleteExpense(expense.id),
              child: ListTile(
                title: Text(expense.description),
                subtitle: Text(
                  '\$${expense.amount.toStringAsFixed(2)} - ${DateFormat('dd/MM/yyyy').format(expense.date)}',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddEditExpensePage(expenseId: expense.id),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddEditExpensePage()),
          );
        },
      ),
    );
  }
}
