import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pharm1_mobile/log%20in_out/screen_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'generated/l10n.dart';
import 'home/screen_home.dart';

late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //من اجل التعريب
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: Directionality(
        textDirection: TextDirection.rtl,
        //من اجل التعريب (النهاية)
        child: sharedPref.getString("id") == null ? login() : MyHomePage(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
