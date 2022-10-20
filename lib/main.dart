import "dart:io";

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:intl/intl.dart";
import 'package:learn_flutter/widgets/home.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isPlatformIos = Platform.isIOS;

    return isPlatformIos
        ? CupertinoApp(
            title: "Personal Expenses",
            theme: CupertinoThemeData(primaryColor: Colors.purple),
            home: const Home(),
          )
        : MaterialApp(
            title: 'Personal Expenses',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              errorColor: Colors.red,
            ),
            home: const Home(),
          );
  }
}
