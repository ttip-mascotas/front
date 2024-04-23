class Treatment {
  final DateTime startDate;
  final String dose;
  final String medicine;
  final int numberOfTime;
  final int frequency;

  Treatment({
    required this.medicine,
    required this.startDate,
    required this.dose,
    required this.numberOfTime,
    required this.frequency,
  });
}