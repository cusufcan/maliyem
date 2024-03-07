import '../constant/index.dart';
import 'index.dart';

String getDayString(DateTime date) {
  final now = DateTime.now();
  final today = clearHour(now);
  final yesterday = today.subtract(const Duration(days: 1));

  final response = clearHour(date);

  if (response == today) {
    return BaseString.today;
  } else if (response == yesterday) {
    return BaseString.yesterday;
  }
  return BaseString.days[date.weekday - 1];
}
