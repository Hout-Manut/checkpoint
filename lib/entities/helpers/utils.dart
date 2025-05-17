import 'package:checkpoint/entities/enums/sport_type.dart';
import 'package:intl/intl.dart';

Sport sportFromString(String str) {
  for (Sport sport in Sport.values) {
    if (str == sport.name) return sport;
  }
  throw Exception("Unknown sport value");
}

String formatDateTime(DateTime dateTime) {
  return DateFormat('EEE. d, MMMM yyyy. ha').format(dateTime);
}

String incrementBib(String bib) {
  if (RegExp(r'\d$').hasMatch(bib)) {
    String nonDigits = bib.replaceAll(RegExp(r'\d+$'), '');
    String digits = bib.replaceAll(RegExp(r'\D'), '');
    int incremented = int.parse(digits) + 1;
    return nonDigits + incremented.toString();
  } else {
    return '${bib}2';
  }
}
