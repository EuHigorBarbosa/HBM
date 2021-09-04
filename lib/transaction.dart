class Transaction {
  final String id;
  final String title;
  final double value;
  final DataTime date;

  Transaction({
    required this.date,
    required this.id,
    required this.title,
    required this.value,
  });
}
