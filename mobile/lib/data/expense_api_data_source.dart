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
    final response = await http.post(
      Uri.parse('$baseUrl/api/expenses'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: json.encode(expense.toJson()),
    );
    if (response.statusCode == 201) {
      return Expense.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to create expense');
  }

  Future<void> updateExpense(Expense expense) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/expenses/${expense.id}'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: json.encode(expense.toJson()),
    );
    if (response.statusCode == 204) {
      return;
    } else if (response.statusCode == 400) {
      throw Exception('Invalid expense data');
    } else if (response.statusCode == 404) {
      throw Exception('Expense not found');
    }
    throw Exception('Failed to update expense');
  }

  Future<void> deleteExpense(String id) async {
    return;
  }
}
