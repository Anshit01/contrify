class Contract {
  String address;
  String creatorName;
  int amount;
  DateTime lastActivity, firstActivity;
  Contract(
      {required this.address,
      required this.amount,
      required this.creatorName,
      required this.firstActivity,
      required this.lastActivity});
  final _months = [
    'Jan',
    'Feb',
    'March',
    'April',
    'May',
    'June',
    'July',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  String get getLastActivity =>
      '${lastActivity.hour}:${lastActivity.minute}  ${lastActivity.day} ${_months[lastActivity.month - 1]}, ${lastActivity.year}';
  String get getFirstActivity =>
      '${firstActivity.hour}:${firstActivity.minute}  ${firstActivity.day} ${_months[firstActivity.month - 1]}, ${firstActivity.year}';
}
