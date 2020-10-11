import 'package:flutter/material.dart';

class FlexibleAppBar {
  static Container gradientColor = Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFFFA32E0C1),
          Color(0xFF31BEA9),
        ],
      ),
    ),
  );
}
