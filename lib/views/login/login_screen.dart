import 'package:structure_example/bloc/bloc_signin.dart';
import 'package:structure_example/resource/colors_data.dart';
import 'package:structure_example/resource/dimen.dart';
import 'package:structure_example/resource/fonts_name.dart';
import 'package:structure_example/resource/fonts_size.dart';
import 'package:structure_example/resource/icons_data.dart';
import 'package:structure_example/utils/validators.dart';
import 'package:structure_example/resource/images_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  BlocSignin _blocSignin = new BlocSignin();
  TextStyle _textStyle = new TextStyle(
      color: ColorsData.green_1, fontFamily: FontsName.nunito_Bold);
  bool _hidePassword = true;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Validator _validator = new Validator();
  FocusNode _focusInput = new FocusNode();
  TextEditingController _textUserName =
      new TextEditingController(text: "f_manager");
  // TextEditingController _textUserName =
  //     new TextEditingController(text: "storeadmin");
  TextEditingController _textPassword =
      new TextEditingController(text: "123123");
  // TextEditingController _textPassword =
  //     new TextEditingController(text: "123123");

  _checkSignin() async {
    if (_formKey.currentState.validate()) {
      bool success =
          await _blocSignin.signin(_textUserName.text, _textPassword.text);
      if (success) Navigator.of(context).pushNamed("/choose_store");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder<bool>(
          stream: _blocSignin.loaddingStream,
          initialData: false,
          builder: (context, snapshotLoadding) {
            return SafeArea(
              child: ListView(
                children: [
                  SizedBox(height: 15),
                  Container(
                    height: size.height / 3,
                    // child: Image.asset(
                    //   ImagesData.structure_example,
                    //   width: size.width / 1.5,
                    // ),
                    child: FlutterLogo(),
                  ),
                  Form(
                    key: _formKey,
                    // autovalidate: true,
                    child: Padding(
                      padding: EdgeInsets.all(Dimen.paddingChild),
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          TextFormField(
                            controller: _textUserName,
                            decoration: InputDecoration(
                              labelText: "Tên đăng nhập",
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              _focusInput.nextFocus();
                            },
                            focusNode: _focusInput,
                            validator: (_) {
                              return _validator.userName(_);
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _textPassword,
                            obscureText: _hidePassword,
                            decoration: InputDecoration(
                              labelText: "Mật khẩu",
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _hidePassword = !_hidePassword;
                                  });
                                },
                                child: _hidePassword
                                    ? Icon(Icons.remove_red_eye)
                                    : Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        child: SvgPicture.asset(
                                          IconsData.hidePassword,
                                          height: 20,
                                          color: ColorsData.blue_1,
                                        ),
                                      ),
                              ),
                            ),
                            // focusNode: _focusInput,
                            onFieldSubmitted: (_) {
                              if (!snapshotLoadding.data) {
                                _checkSignin();
                              }
                            },
                            validator: (_) {
                              return _validator.password(_);
                            },
                          ),
                          SizedBox(height: 40),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: snapshotLoadding.data ? 100 : size.width,
                            child: RaisedButton(
                              onPressed: () {
                                if (!snapshotLoadding.data) {
                                  _checkSignin();
                                }
                              },
                              child: snapshotLoadding.data
                                  ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : Text(
                                      "Login",
                                      style: TextStyle(
                                          fontSize: FontsSize.textButtonSmall),
                                    ),
                              padding: EdgeInsets.symmetric(vertical: 13),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // GestureDetector(
                              //   onTap: () {},
                              //   child: Text(
                              //     "Đăng ký",
                              //     style: TextStyle(
                              //         color: ColorsData.blue_1,
                              //         fontFamily: FontsName.nunito_Bold),
                              //   ),
                              // ),
                              // Text("  |  ", style: _textStyle),
                              GestureDetector(
                                onTap: () {},
                                child: Text("Quên mật khẩu", style: _textStyle),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
