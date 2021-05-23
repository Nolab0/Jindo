import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//stripped line separator
class Separator extends StatelessWidget {
  final double totalWidth, dashWidth, emptyWidth, dashHeight;

  final Color dashColor;

  const Separator({
    this.totalWidth = 300,
    this.dashWidth = 10,
    this.emptyWidth = 5,
    this.dashHeight = 2,
    this.dashColor = Colors.black,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          totalWidth ~/ (dashWidth + emptyWidth),
          (_) => Container(
            width: dashWidth,
            height: dashHeight,
            color: dashColor,
            margin:
                EdgeInsets.only(left: emptyWidth / 2, right: emptyWidth / 2),
          ),
        ),
      ),
    );
  }
}
