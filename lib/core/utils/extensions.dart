import 'validators.dart';

extension DateTimeExtensions on DateTime {
  String toShortDate() => '$day/$month/$year';

  String toLongDate() => '$day ${_monthName(month)} $year';

  String toTime() =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  String _monthName(int month) {
    const names = [
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
      'Dec',
    ];
    return names[month - 1];
  }

  bool isToday() {
    final now = DateTime.now();
    return day == now.day && month == now.month && year == now.year;
  }

  bool isSameDay(DateTime other) {
    return day == other.day && month == other.month && year == other.year;
  }
}

extension StringExtensions on String {
  bool get isValidEmail => Validators.isValidEmail(this);

  bool get isValidPassword => Validators.isValidPassword(this);

  bool get isValidPhone => Validators.isValidPhone(this);

  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String toTitleCase() =>
      split(' ').where((e) => e.isNotEmpty).map((e) => e.capitalize()).join(' ');
}
