// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_nodejs_1/screens/home.dart';
import 'package:flutter_nodejs_1/screens/register.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(token: prefs.getString("token") ?? ""));
}

class MyApp extends StatelessWidget {
  String? token;

  MyApp({super.key, this.token = ""});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      navigatorKey: Application.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: token == ""
          ? RegisterScreen()
          : (JwtDecoder.isExpired(token ?? "") == false)
              ? HomeScreen(token: token!)
              : RegisterScreen(),
    );
  }
}
