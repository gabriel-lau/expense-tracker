import 'dart:io';

import 'package:expense_tracker/data/expense_api_data_source.dart';
import 'package:expense_tracker/repositories/expense_repository.dart';
import 'package:expense_tracker/repositories/expense_repository_impl.dart';
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
      create: (_) => ExpenseViewModel(
        repository: ExpenseRepositoryApiImpl(
          Platform.isAndroid
              ? ExpenseApiDataSource(baseUrl: 'http://10.0.2.2')
              : ExpenseApiDataSource(baseUrl: 'http://127.0.0.1'),
        ),
      ),
      child: MaterialApp(
        title: 'Expense Tracker',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const ExpenseListPage(),
      ),
    );
  }
}
