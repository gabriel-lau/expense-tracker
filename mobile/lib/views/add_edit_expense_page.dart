import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../viewmodels/expense_viewmodel.dart';

// The widget that uses AddEditExpensePage has no visibility into the underlying values and no means to access or change it.
class AddEditExpensePage extends StatefulWidget {
  final String? expenseId;
  const AddEditExpensePage({super.key, this.expenseId});

  // The _AddEditExpensePageState is created the first time that AddEditExpensePage is built, and exist until it's removed from the screen.
  // This is an example of ephemeral state.
  @override
  State<AddEditExpensePage> createState() => _AddEditExpensePageState();
}

class _AddEditExpensePageState extends State<AddEditExpensePage> {
  final _formKey = GlobalKey<FormState>();
  late String _description;
  late double _amount;
  late DateTime _date;
  late bool isEdit;
  late Expense? expense;

  @override
  void initState() {
    super.initState();
    final vm = Provider.of<ExpenseViewModel>(context, listen: false);
    isEdit = widget.expenseId != null;
    expense = isEdit ? vm.getExpenseById(widget.expenseId!) : null;
    _date = expense?.date.toLocal() ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ExpenseViewModel>(context);
    // final isEdit = widget.expenseId != null;
    // final expense = isEdit ? vm.getExpenseById(widget.expenseId!) : null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Expense' : 'Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: expense?.description ?? '',
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter description' : null,
                onSaved: (value) => _description = value!,
              ),
              TextFormField(
                initialValue: expense?.amount.toString() ?? '',
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter amount';
                  if (double.tryParse(value) == null)
                    return 'Enter valid number';
                  return null;
                },
                onSaved: (value) => _amount = double.parse(value!),
              ),
              Row(
                children: [
                  Text('Date: ${DateFormat('dd/MM/yyyy').format(_date)}'),
                  TextButton(
                    child: const Text('Pick Date'),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _date.toLocal(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          _date = picked;
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: Text(isEdit ? 'Save' : 'Add'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (isEdit) {
                      vm.editExpense(
                        widget.expenseId!,
                        _description,
                        _amount,
                        _date,
                      );
                    } else {
                      vm.addExpense(_description, _amount, _date);
                    }
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
