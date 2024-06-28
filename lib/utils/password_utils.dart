import 'dart:convert';

class PasswordUtils {
  static String encodePassword(String password) {
    return base64Encode(utf8.encode(password));
  }

  static String decodePassword(String encodedPassword) {
    return utf8.decode(base64Decode(encodedPassword));
  }

  static bool validatePassword(String inputPassword, String encodedPassword) {
    String decodedPassword = decodePassword(encodedPassword);
    return inputPassword == decodedPassword;
  }
}
