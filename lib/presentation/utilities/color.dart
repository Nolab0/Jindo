import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Return the gradients of the app

//Main gradient
Gradient gradient() {
  return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        Color(0xff11998e).withOpacity(0.8),
        Color(0xff38ef7d).withOpacity(0.8)
      ]);
}

Gradient lightgradient() {
  return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        Color(0xff11998e).withOpacity(0.5),
        Color(0xff38ef7d).withOpacity(0.5)
      ]);
}

Gradient whiteGradient() {
  return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [Colors.white, Colors.white]);
}

Gradient redGradient() {
  return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        Color(0xffe52d27).withOpacity(0.8),
        Color(0xffb31217).withOpacity(0.8)
      ]);
}
