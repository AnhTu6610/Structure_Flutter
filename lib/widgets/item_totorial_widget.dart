import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:structure_example/resource/colors_data.dart';
import 'package:structure_example/resource/fonts_name.dart';

class ItemTotorialWidget extends StatefulWidget {
  final VoidCallback ontap;
  final String icon;
  final String text;

  const ItemTotorialWidget({Key key, this.ontap, this.icon, this.text}) : super(key: key);
  @override
  _ItemTotorialWidgetState createState() => _ItemTotorialWidgetState();
}

class _ItemTotorialWidgetState extends State<ItemTotorialWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: ColorsData.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(100),
              ),
              child: SvgPicture.asset(widget.icon),
            ),
            SizedBox(height: 10),
            Text(widget.text, style: TextStyle(fontFamily: FontsName.medium)),
          ],
        ),
      ),
    );
  }
}
