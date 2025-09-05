class Expense {
  String? id;
  String description;
  double amount;
  DateTime date;

  Expense({
    this.id,
    required this.description,
    required this.amount,
    required this.date,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'] as String?,
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (id != null) 'id': id,
      'description': description,
      'amount': amount,
      'date': date.toUtc().toIso8601String(),
    };
  }
}
