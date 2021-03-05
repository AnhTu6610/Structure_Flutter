import 'package:flutter/material.dart';
import 'package:structure_example/app_localizations.dart';
import 'package:structure_example/models/response_model/handbook_category_res.dart';
import 'package:structure_example/resource/colors_data.dart';

class ChipcategoryHandBook extends StatefulWidget {
  final List<CategoryHandBook> categoryHandBook;
  const ChipcategoryHandBook({Key key, this.categoryHandBook}) : super(key: key);
  @override
  _ChipcategoryState createState() => _ChipcategoryState();
}

class _ChipcategoryState extends State<ChipcategoryHandBook> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoryHandBook.length + 1,
        itemBuilder: (context, index) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(left: 15),
              child: index == 0
                  ? RaisedButton(
                      onPressed: () {},
                      child: Text(translate(context, "all")),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                    )
                  : OutlineButton(
                      onPressed: () {},
                      child: Text(widget.categoryHandBook[index - 1].name),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      textColor: ColorsData.primary,
                      borderSide: BorderSide(color: ColorsData.primary),
                    ),
            ),
          );
        },
      ),
    );
  }
}
