import 'package:flutter/material.dart';
import 'package:whispery/login_page.dart';
import 'package:whispery/theme/themes.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  createState() => _MyApp();
}

class _MyApp extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: androidTheme,
      home: LoginPage(),
    );
    // return MaterialApp(
    //   theme: androidTheme,
    //   home: FutureBuilder<SharedPreferences>(
    //       future: SharedPreferences.getInstance(),
    //       builder: (BuildContext context, AsyncSnapshot snapshot) {
    //         switch (snapshot.connectionState) {
    //           case ConnectionState.none:
    //           case ConnectionState.waiting:
    //             return Text("Awating connection...");
    //           default:
    //             if (!snapshot.hasError) {
    //               return snapshot.data.getString("username") != null
    //                   ? LandingPage()
    //                   : LoginPage();
    //             } else {
    //               return Text("An error has occured.");
    //             }
    //         }
    //       }),
    // );
  }
}
