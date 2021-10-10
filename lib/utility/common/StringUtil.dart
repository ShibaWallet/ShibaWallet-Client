


class StringUtil {

  // 移除字符串尾部的指定字符
  static String trimLastCharacters(String srcStr, String pattern) {   
    if (srcStr == "0.0") {
      return srcStr;
    }
    if (srcStr.length > 0) {   
      if (srcStr.endsWith(pattern)) { 
        final v = srcStr.substring(0, srcStr.length - pattern.length);
        return trimLastCharacters(v, pattern);
      } 
      return srcStr; 
    }   
    return srcStr;
  }


}