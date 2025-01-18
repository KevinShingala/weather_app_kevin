  import 'package:intl/intl.dart';

String dateAndTime({required int timestamp}) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String formattedDate = DateFormat('MMMM dd, HH:mm').format(dateTime);
    return formattedDate;
  }