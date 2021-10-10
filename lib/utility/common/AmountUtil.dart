import 'package:truthywallet/utility/common/StringUtil.dart';

class AmountUtil {
  static String getAmountToStr(double amount) {
    String r = "";
    if (amount == 0.0) {
      r = "0.0";
    } else if (amount < 10) {
      r = amount.toStringAsFixed(10);
    } else if (amount >= 10 && amount < 100) {
      r = amount.toStringAsFixed(9);
    } else if (amount >= 100 && amount < 1000) {
      r = amount.toStringAsFixed(8);
    } else if (amount >= 1000 && amount < 10000) {
      r = amount.toStringAsFixed(7);
    } else if (amount >= 10000 && amount < 100000) {
      r = amount.toStringAsFixed(6);
    } else if (amount >= 100000 && amount < 1000000) {
      r = amount.toStringAsFixed(5);
    } else if (amount >= 1000000 && amount < 10000000) {
      r = amount.toStringAsFixed(4);
    } else if (amount >= 10000000 && amount < 100000000) {
      r = amount.toStringAsFixed(3);
    } else if (amount >= 100000000 && amount < 1000000000) {
      r = amount.toStringAsFixed(2);
    } else if (amount >= 1000000000) {
      r = amount.toStringAsFixed(1);
    } else {
      r = amount.toInt().toString();
    }
    var r1 = StringUtil.trimLastCharacters(r, "0");
    if (r1.endsWith(".")) {
      return "${r1}0";
    }
    return r1;
  }

  static String getAmountToStr1(double amount) {
    String r = "";
    if (amount == 0.0) {
      r = "0.0";
    } else if (amount < 0.00001) {
      r = amount.toStringAsFixed(12);
    } else if (amount >= 0.00001 && amount < 0.01) {
      r = amount.toStringAsFixed(5);
    } else if (amount >= 0.01 && amount < 10) {
      r = amount.toStringAsFixed(3);
    } else if (amount >= 10 && amount < 100) {
      r = amount.toStringAsFixed(4);
    } else if (amount >= 100 && amount < 1000) {
      r = amount.toStringAsFixed(5);
    } else if (amount >= 1000 && amount < 10000) {
      r = amount.toStringAsFixed(4);
    } else if (amount >= 10000 && amount < 100000) {
      r = amount.toStringAsFixed(4);
    } else if (amount >= 100000 && amount < 1000000) {
      r = amount.toStringAsFixed(3);
    } else if (amount >= 1000000 && amount < 10000000) {
      r = amount.toStringAsFixed(2);
    } else if (amount >= 10000000 && amount < 100000000) {
      r = amount.toStringAsFixed(1);
    } else if (amount >= 100000000 && amount < 1000000000) {
      r = amount.toStringAsFixed(1);
    } else if (amount >= 1000000000) {
      r = amount.toStringAsFixed(1);
    } else {
      r = amount.toInt().toString();
    }
    var r1 = StringUtil.trimLastCharacters(r, "0");
    if (r1.endsWith(".")) {
      return "${r1}0";
    }
    return r1;
  }

  static String getAmountForShortStr(double amount) {
    if (amount == 0) {
      return "0";
    } 
    if (amount < 10) {
      return amount.toStringAsFixed(4);
    } else if (amount >= 10 && amount < 1000000) {
      return amount.toStringAsFixed(2);
    } else if (amount >= 1000000 && amount < 1000000000) {
      return (amount / 1000000).toStringAsFixed(2) + "M";
    } else if (amount >= 1000000000) {
      return (amount / 1000000000).toStringAsFixed(2) + "B";
    } else {
      return amount.toInt().toString();
    }
  }

  static String getShortAddress(String address) { 
    if (address.length <= 0) {
      return "";
    }
    final prefix = address.substring(0, 9);
    final suffix = address.substring(address.length - 10);
    final r = "$prefix.....$suffix"; 
    return r;
  }

  static String getShort4Address(String address) {
    if (address.length <= 0) {
      return "";
    }
    final prefix = address.substring(0, 4);
    final suffix = address.substring(address.length - 4);
    return "$prefix.....$suffix";
  }

  static String getShortAddressByPlaces(String address, int places) {
    if (address.length <= 0) {
      return "";
    }
    final prefix = address.substring(0, places);
    final suffix = address.substring(address.length - places);
    return "$prefix.....$suffix";
  }

  // 处理数字科学记数的问题
  static String handleScienceNotationNum(double n) {
    if (!(n.toString().contains("e-"))) {
      return n.toString();
    }
    return StringUtil.trimLastCharacters(n.toStringAsFixed(18), "0");
  }

  static double convertToDouble(dynamic n) {
    if (n.runtimeType == String) {
      return double.parse(n);
    } else if (n.runtimeType == int) {
      return double.parse(n.toString());
    } else {
      return n as double;
    }
  }

}
