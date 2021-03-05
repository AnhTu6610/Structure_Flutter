import 'package:flutter/material.dart';
import 'package:structure_example/resource/colors_data.dart';

class NotificationWidget extends StatefulWidget {
  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("/notification");
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Icon(Icons.notifications, color: Colors.white, size: 30),
          Visibility(
            visible: 0 != 0,
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: ColorsData.primary, width: 2),
                borderRadius: BorderRadius.circular(100),
              ),
              child: FittedBox(child: Text("1")),
            ),
          ),
        ],
      ),
    );
  }
}
