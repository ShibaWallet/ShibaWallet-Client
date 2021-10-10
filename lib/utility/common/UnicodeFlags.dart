class UnicodeFlags {
  // 根据国家的code显示unicode国旗
  static String getFlagWithCode(String code) {
    String flag = code.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
    return flag;
  }
}
