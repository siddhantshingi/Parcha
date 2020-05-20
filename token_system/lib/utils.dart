List<String> monthFull = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

List<String> monthAbbr = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

String slotNumStartTime(int slotNumber) {
  int _hour = 6;
  String _minutes = '00';
  String _meridian = 'AM';
  String pref = '';
  if (slotNumber % 2 == 0) _minutes = '30';
  slotNumber = (slotNumber - 1)~/2;
  _hour += slotNumber;
  if (_hour >= 12) _meridian = 'PM';
  if (_hour >= 13) _hour -= 12;
  if (_hour < 10) pref = '0';
  String _hours = pref + _hour.toString();

  return _hours + ':' + _minutes + ' ' + _meridian;
}

String slotNumEndTime(int slotNumber) {
  return slotNumStartTime(slotNumber + 1);
}

String readableDate(String date) {
  // date = 'YYYY-MM-DD'
  int _month = int.parse(date.substring(5, 7));
  int _day = int.parse(date.substring(8, 10));

  String day = '';
  day += monthAbbr[_month] + ' ';
  day += _day.toString();
  return day;
}

String readableTimestamp(String timestamp) {
  // timestamp = 'YYYY-MM-DD HH:MM:SS'
  String _date = readableDate(timestamp.substring(0, 10));
  return _date + ' ' + timestamp.substring(12);
}

DateTime stampStart(String date, int slotNumber) {
  // date = 'YYYY-MM-DD'
  int _hour = 6;
  String _minutes = '00';
  String _rem = '00.0';
  String _prefix = '';
  if (slotNumber % 2 == 0) _minutes = '30';
  slotNumber ~/= 2;
  _hour += slotNumber;
  if (_hour < 10)
    _prefix = '0';

  String stamp = date + ' ' + _prefix + _hour.toString() + ':' + _minutes + ':' + _rem;
  return DateTime.parse(stamp);
}

DateTime stampEnd(String date, int slotNumber) {
  return stampStart(date, slotNumber + 1);
}

String stripSeconds(String time) {
  // time = 'HH:MM:SS'
  return time.substring(0, 5);
}

DateTime stamp(String date, String time) {
  String _parsable = date + ' ' + time;
  _parsable += ':00.0';
  return DateTime.parse(_parsable);
}