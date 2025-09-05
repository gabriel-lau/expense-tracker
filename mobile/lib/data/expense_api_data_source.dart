import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/expense.dart';

class ExpenseApiDataSource {
  final String baseUrl;

  ExpenseApiDataSource({required this.baseUrl});

  Future<List<Expense>> fetchExpenses() async {
    final response = await http.get(Uri.parse('$baseUrl/api/expenses'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Expense.fromJson(e)).toList();
    }
    throw Exception('Failed to load expenses');
  }

  Future<Expense> createExpense(Expense expense) async {
    var expenseJson = json.encode(expense.toJson());
    final response = await http.post(
      Uri.parse('$baseUrl/api/expenses'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: expenseJson,
    );
    if (response.statusCode == 201) {
      return Expense.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to create expense');
  }

  Future<Expense> updateExpense(Expense expense) async {
    return expense;
  }

  Future<void> deleteExpense(String id) async {
    return;
  }
}
