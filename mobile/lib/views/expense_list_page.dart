import 'package:expense_tracker/views/add_edit_expense_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart'; // Provider with ChangeNotifier - Automatic rebuilds of UI on data change so we don't have to use setState
import '../viewmodels/expense_viewmodel.dart';

class ExpenseListPage extends StatefulWidget {
  const ExpenseListPage({super.key});

  @override
  State<ExpenseListPage> createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {
  @override
  void initState() {
    super.initState();
    // Only load expenses once when the page is first created
    Future.microtask(() {
      final vm = Provider.of<ExpenseViewModel>(context, listen: false);
      vm.loadExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ExpenseViewModel>(context);
    // Show error message if exists
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (vm.errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(vm.errorMessage!)));
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: vm.isLoading
              ? LinearProgressIndicator(
                  value: vm.isLoading ? null : 0.0, // Show if isLoading is true
                )
              : SizedBox.shrink(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          vm.loadExpenses();
          return Future.value();
        },
        child: ListView.builder(
          itemCount: vm.expenses.length,
          itemBuilder: (context, index) {
            final expense = vm.expenses[index];
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) => vm.deleteExpense(expense.id!),
              child: ListTile(
                title: Text(expense.description),
                subtitle: Text('\$${expense.amount.toStringAsFixed(2)}'),
                trailing: Text(
                  DateFormat('dd/MM/yyyy').format(expense.date.toLocal()),
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
