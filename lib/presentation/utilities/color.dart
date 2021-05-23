import 'dart:ui';
import 'package:flutter/cupertino.dart';

//return the gradient of the app.
Gradient gradient() {
  return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xff20BF55), Color(0xff01BAEF)]);
}
