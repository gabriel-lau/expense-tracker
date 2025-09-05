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
    // Manually format to ISO8601 without milliseconds
    String twoDigits(int n) {
      if (n >= 10) return "${n}";
      return "0${n}";
    }

    final utc = date.toUtc();
    final isoString =
        '${utc.year}-${twoDigits(utc.month)}-${twoDigits(utc.day)}T'
        '${twoDigits(utc.hour)}:${twoDigits(utc.minute)}:${twoDigits(utc.second)}Z';
    return <String, dynamic>{
      if (id != null) 'id': id,
      'description': description,
      'amount': amount,
      'date': isoString,
    };
  }
}
