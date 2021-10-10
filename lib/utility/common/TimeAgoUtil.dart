/*
 * example: https://pub.dev/packages/timeago/example
 */

import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class TimeAgoUtil {
  // 例如：2 days ago、a day ago
  static String timeAgo(int timestamp) { 
    DateTime theDate = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return timeago.format(theDate, locale: "en_US");
  }

  static String getDateTimeStr(int timestamp) { 
    var dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var dtstr = DateFormat('MM/dd/yyyy hh:mm a').format(dt);
    return dtstr;
  }

  static String getDateTimeZ(int timestamp) { 
    var dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var dtstr = DateFormat('yyyy-MM-dd hh:mm:ss a').format(dt);
    return dtstr;
  } 

  static String getDateStr(int timestamp, {String format = "yyyy-MM-dd"}) { 
    var dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var d12 = DateFormat(format).format(dt);
    return d12;
  }

  // 当前日期，比如：2021-08-03
  static String getCurrentDateStr() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  // 当前日期，比如：2021-09-11 18:51:01 
  static String getCurrentDateTimeStr() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd hh:mm:ss a');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  // static String timeAgoSinceDate(String dateString,
  //     {bool numericDates = true}) {
  //   DateTime notificationDate =
  //       DateFormat("dd-MM-yyyy h:mma").parse(dateString);
  //   final date2 = DateTime.now();
  //   final difference = date2.difference(notificationDate);

  //   if (difference.inDays > 8) {
  //     return dateString;
  //   } else if ((difference.inDays / 7).floor() >= 1) {
  //     return (numericDates) ? '1 week ago' : 'Last week';
  //   } else if (difference.inDays >= 2) {
  //     return '${difference.inDays} days ago';
  //   } else if (difference.inDays >= 1) {
  //     return (numericDates) ? '1 day ago' : 'Yesterday';
  //   } else if (difference.inHours >= 2) {
  //     return '${difference.inHours} hours ago';
  //   } else if (difference.inHours >= 1) {
  //     return (numericDates) ? '1 hour ago' : 'An hour ago';
  //   } else if (difference.inMinutes >= 2) {
  //     return '${difference.inMinutes} minutes ago';
  //   } else if (difference.inMinutes >= 1) {
  //     return (numericDates) ? '1 minute ago' : 'A minute ago';
  //   } else if (difference.inSeconds >= 3) {
  //     return '${difference.inSeconds} seconds ago';
  //   } else {
  //     return 'Just now';
  //   }
  // }
}
