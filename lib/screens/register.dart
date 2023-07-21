// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields, unused_field, unused_local_variable

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_nodejs_1/constants/navigator/page_route_effect.dart';
import 'package:flutter_nodejs_1/helpers/config.dart';
import 'package:flutter_nodejs_1/navigator/navigator.dart';
import 'package:flutter_nodejs_1/screens/login.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isValid = true;

  void registerUser() async {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      var requestBody = {
        "email": _emailController.text,
        "password": _passwordController.text,
      };
      log(Configiration.registerUrl);

      var response = await http.post(
        Uri.parse(Configiration.registerUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      var jsonResponse = jsonDecode(response.body);

      log(jsonResponse["status"].toString());

      if (jsonResponse["status"] == true) {
        AppNavigator.push(screen: LoginScreen(), effect: AppRouteEffect.rightToLeft);
        log("BAŞARILI");
      } else {}

      setState(() {
        _isValid = true;
      });
    } else {
      setState(() {
        _isValid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Create an account",
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Email",
                          errorText: _isValid ? null : "Enter Proper Info",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Password",
                          errorText: _isValid ? null : "Enter Proper Info",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    SizedBox(height: 75),
                    Center(
                      child: GestureDetector(
                        onTap: () => registerUser(),
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(5),
                          child: Center(
                            child: Text(
                              "Register",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => AppNavigator.push(screen: LoginScreen(), effect: AppRouteEffect.rightToLeft),
                      child: Center(
                        child: Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
