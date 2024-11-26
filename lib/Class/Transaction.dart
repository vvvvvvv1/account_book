class Transaction {
  final String date;
  final String dayOfWeek;
  final String category;
  final String description;
  final String time;
  final String bank;
  final int income;
  final int expense;

  Transaction({
    required this.date,
    required this.dayOfWeek,
    required this.category,
    required this.description,
    required this.time,
    required this.bank,
    required this.income,
    required this.expense,
  });
}
