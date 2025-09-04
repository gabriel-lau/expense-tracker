import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/expense_viewmodel.dart';

class ExpenseListPage extends StatelessWidget {
  const ExpenseListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ExpenseViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Expenses')),
      body: ListView.builder(
        itemCount: vm.expenses.length,
        itemBuilder: (context, index) {
          final expense = vm.expenses[index];
          return Dismissible(
            key: Key(expense.id),
            onDismissed: (diredtion) => vm.deleteExpense(expense.id),
            child: ListTile(
              title: Text(expense.description),
              subtitle: Text(
                '\$${expense.amount.toStringAsFixed(2)} - ${expense.date.toLocal().toString().split(' ')[0]}',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ExpenseListPage()),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ExpenseListPage()),
          );
        },
      ),
    );
  }
}
