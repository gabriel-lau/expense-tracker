import 'package:expense_tracker/viewmodels/expense_viewmodel.dart';
import 'package:expense_tracker/views/expense_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExpenseViewModel(),
      child: MaterialApp(
        title: 'Expense Tracker',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const ExpenseListPage(),
      ),
    );
  }
}
