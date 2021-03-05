extension Validation on String {
  bool isImgUrl() {
    if (this.isEmpty || this == "") return false;
    // RegExp regExp = new RegExp("/([a-z\-_0-9\/\:\.]*\.(jpg|jpeg|png|gif))/i");
    // if (!regExp.hasMatch(this)) return true;
    var last = this.split(".").last;
    if (last == "jpg" || last == "jpeg" || last == "png" || last == "gif") return true;
    return false;
  }

  String isPhoneValid() {
    if (this.isEmpty || this == "") {
      return "Số điện thoại trống";
    }
    RegExp regExp = new RegExp("^[0-9]{10,11}\$");
    if (!regExp.hasMatch(this)) return "Số điện thoại không hợp lệ";
    return null;
  }

  String userNameValid() {
    if (this == "") {
      return "Tài khoản trống";
    }
    return null;
  }

  String passwordValid() {
    if (this == "") {
      return "Mật khẩu trống";
    }
    if (this.length < 6) {
      return "Mật khẩu phải trên 6 ký tự";
    }
    return null;
  }

  String emailValid() {
    if (this == "") {
      return "Email trống";
    }
    return null;
  }

  String comparePassWord(String repass) {
    if (this != repass) {
      return "Mật khẩu không khớp";
    }
    // ....
    return null;
  }
}

class Validator {
  bool comparePassWord(String pass, String repass) {
    if (pass == repass) {
      return true;
    }
    // ....
    return false;
  }
}
