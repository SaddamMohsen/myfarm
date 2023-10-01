import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:intl/intl.dart' show DateFormat;

extension FullMonthDayDate on EasyDateFormatterCust {
  static String fullDayNameCust(DateTime date, String locale) {
    return DateFormat('yMMMMEEEEd', locale).format(date);
  }
}

mixin EasyDateFormatterCust {}
