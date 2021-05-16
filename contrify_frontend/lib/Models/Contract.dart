class Contract {
  String address;
  String creatorName;
  String amount;
  String lastActivity, firstActivity, url;
  Contract(
      {required this.address,
      required this.amount,
      required this.creatorName,
      required this.firstActivity,
      required this.lastActivity,
      required this.url});

  factory Contract.fromJson(Map data) {
    return Contract(
        url: data['url'],
        address: data['address'],
        amount: data['balance'].toString(),
        creatorName:
            data['creatorName'].length == 0 ? 'Unknown' : data['creatorName'],
        firstActivity: data['firstActivity'],
        lastActivity: data['lastActivity']);
  }

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

  String get getLastActivity {
    final data = lastActivity.split(' ');
    final day = data[0].split('-');
    final time = data[2].split(':');
    return '${time[0]}:${time[1]}  ${day[2]} ${_months[int.parse(day[1]) - 1]}, ${day[0]}';
  }

  String get getFirstActivity {
    final data = firstActivity.split(' ');
    final day = data[0].split('-');
    final time = data[2].split(':');

    return '${time[0]}:${time[1]}  ${day[2]} ${_months[int.parse(day[1]) - 1]}, ${day[0]}';
  }

  // '${lastActivity.hour}:${lastActivity.minute}  ${lastActivity.day} ${_months[lastActivity.month - 1]}, ${lastActivity.year}';
  // '${firstActivity.hour}:${firstActivity.minute}  ${firstActivity.day} ${_months[firstActivity.month - 1]}, ${firstActivity.year}';
}
