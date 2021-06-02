import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Personalized class to display a gradient button
//(action of the button should be done with a gesture detector)
class GradientButton extends StatefulWidget {
  final Text text;
  final Gradient gradient;
  final double width;
  final double height;
  final bool border;
  GradientButton(
      {this.text, this.gradient, this.width, this.height, this.border});

  @override
  _GradientButtonState createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            border: widget.border
                ? Border.all(color: Colors.grey[400], width: 2)
                : null,
            gradient: widget.gradient,
            borderRadius: BorderRadius.circular(10.0)),
        child: Center(child: widget.text));
  }
}
