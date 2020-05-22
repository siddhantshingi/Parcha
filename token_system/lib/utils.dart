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

var timeSlotNumberMap = <String, int>{
  '06:00:00': 1,
  '06:30:00': 2,
  '07:00:00': 3,
  '07:30:00': 4,
  '08:00:00': 5,
  '08:30:00': 6,
  '09:00:00': 7,
  '09:30:00': 8,
  '10:00:00': 9,
  '10:30:00': 10,
  '11:00:00': 11,
  '11:30:00': 12,
  '12:00:00': 13,
  '12:30:00': 14,
  '13:00:00': 15,
  '13:30:00': 16,
  '14:00:00': 17,
  '14:30:00': 18,
  '15:00:00': 19,
  '15:30:00': 20,
  '16:00:00': 21,
  '16:30:00': 22,
  '17:00:00': 23,
  '17:30:00': 24,
  '18:00:00': 25,
  '18:30:00': 26,
  '19:00:00': 27,
  '19:30:00': 28,
  '20:00:00': 29,
  '20:30:00': 30,
  '21:00:00': 31,
  '21:30:00': 32,
};

int timeToSlotNumber(int hour, int min) {
  print(hour);
  print(min);
  var hour_string = '';
  if (hour < 10)
    hour_string = '0' + hour.toString();
  else
    hour_string = hour.toString();
  print(timeSlotNumberMap['03:00:00']);
  if (min < 30) {
    print(hour_string + ":00:00");
    return timeSlotNumberMap[hour_string + ":00:00"];
  } else {
    print(hour_string + ":30:00");
    return timeSlotNumberMap[hour_string + ":30:00"];
  }
}

String slotNumStartTime(int slotNumber) {
  int _hour = 6;
  String _minutes = '00';
  String _meridian = 'AM';
  String pref = '';
  if (slotNumber % 2 == 0) _minutes = '30';
  slotNumber = (slotNumber - 1) ~/ 2;
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

String meridianTo24(String time) {
  // time = 'HH:MM AM' or 'HH:MM PM'
  int _hour;
  if (time.substring(6) == 'AM')
    return time.substring(0, 5);
  else
    _hour = int.parse(time.substring(0, 2));
  if (_hour != 12) _hour += 12;
  return _hour.toString() + time.substring(2, 5);
}

String readableDate(String date) {
  // date = 'YYYY-MM-DD'
  int _month = int.parse(date.substring(5, 7));
  int _day = int.parse(date.substring(8, 10));

  String day = '';
  day += monthAbbr[_month - 1] + ' ';
  day += _day.toString();
  return day;
}

String readableTimestamp(String timestamp) {
  // timestamp = 'YYYY-MM-DD HH:MM:SS'
  String _date = readableDate(timestamp.substring(0, 10));
  return _date + ' ' + timestamp.substring(11);
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
  if (_hour < 10) _prefix = '0';

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
