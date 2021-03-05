import 'package:flutter/material.dart';
import 'package:structure_example/resource/colors_data.dart';
import 'package:structure_example/resource/dimen.dart';
import 'package:structure_example/resource/texts_stype.dart';

class DialogPaymentSuccess extends StatefulWidget {
  @override
  _DialogPaymentSuccessState createState() => _DialogPaymentSuccessState();
}

class _DialogPaymentSuccessState extends State<DialogPaymentSuccess> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: size.width / 6),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.all(Dimen.marginsContent),
                    margin: EdgeInsets.symmetric(horizontal: Dimen.marginsContent * 2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: size.width / 6),
                        Text("Đặt hàng thành công !", style: TextsStyle.subject.copyWith(color: Colors.black)),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: OutlineButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil("/home", ModalRoute.withName('/home'));
                                },
                                child: Text("Về trang chủ"),
                                color: ColorsData.primary,
                                textColor: ColorsData.primary,
                                borderSide: BorderSide(color: ColorsData.primary),
                              ),
                            ),
                            // SizedBox(width: 15),
                            // Expanded(
                            //   child: RaisedButton(
                            //     onPressed: () {
                            //       Navigator.of(context).pushNamedAndRemoveUntil("/home", ModalRoute.withName('/home'));
                            //     },
                            //     child: Text("Tiếp tục mua"),
                            //     elevation: 0,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: (size.width / 6) * 2,
                height: (size.width / 6) * 2,
                decoration: BoxDecoration(
                  color: ColorsData.primary,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.white, width: 5),
                ),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(Icons.check, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
