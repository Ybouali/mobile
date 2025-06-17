import 'package:intl/intl.dart';

class EntryUtilsFunctions {
  String getNameOfMonth(DateTime date) {
    return DateFormat('MMMM').format(date);
  }

  (String, String) getYearAndDay(DateTime date) {
    List<String> split = date.toString().split(" ");

    split = split.first.split("-");

    return (split[0], split[2]);
  }

  String getNameOfDay(DateTime date) {
    return DateFormat.EEEE().format(date);
  }
}
