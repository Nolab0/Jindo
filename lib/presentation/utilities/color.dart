import 'dart:ui';
import 'package:flutter/cupertino.dart';

//return the gradient of the app.
Gradient gradient() {
  return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xff11998e).withOpacity(0.8),
        Color(0xff38ef7d).withOpacity(0.8)
      ]);
}
