import 'package:flutter/cupertino.dart';

class VerticalDivader2 extends StatelessWidget {
  Color color;
  double margin;
  VerticalDivader2({super.key, required this.color, this.margin = 5});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      color: color,
      margin: EdgeInsets.symmetric(horizontal: margin),
    );
  }
}
