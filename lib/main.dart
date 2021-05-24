import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greennindo/presentation/views/loading.dart';
import 'package:provider/provider.dart';
import 'business_logic/auth.dart';
import 'business_logic/wrapper.dart';
import 'models/user_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(LaunchPage());
}

class LaunchPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Error in initialization");
          return null;
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<CustUser>.value(
            initialData: CustUser(uid: null),
            value: AuthService().user,
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    textTheme: GoogleFonts.nunitoSansTextTheme(
                        Theme.of(context).textTheme)),
                home: Wrapper()),
          );
        }
        return MaterialApp(home: Loading());
      },
    );
  }
}
