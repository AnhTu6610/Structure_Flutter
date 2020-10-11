class Validator {
  String userName(String text) {
    if (text == "") {
      return "Tài khoản trống";
    }
    return null;
  }

  String password(String text) {
    if (text == "") {
      return "Mật khẩu trống";
    }
    return null;
  }
}
