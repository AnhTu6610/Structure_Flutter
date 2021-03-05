import 'package:structure_example/utils/enum_value.dart';

class ArgRegister {
  String name;
  String phone;
  String pass;
  ArgRegister({this.name, this.phone, this.pass});
}

class ArgVerified {
  OptionOtp optionOtp;
  String phone;
  String token;
  ArgVerified({this.phone, this.token, this.optionOtp});
}

class ArgChangePass {
  OptionChangePass optionChangePass;
  ArgChangePass({this.optionChangePass});
}

class ArgUpdateProfileSocial {
  String token;
  ArgUpdateProfileSocial({this.token});
}
