import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greennindo/presentation/views/mainPage.dart';
import 'package:greennindo/presentation/views/welcomePage.dart';

void main() {
  runApp(LaunchPage());
}

class LaunchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme:
                GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme)),
        home: MainPage());
  }
}
