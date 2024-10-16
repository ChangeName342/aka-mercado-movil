import 'dart:convert';

import 'package:aka_mercado/constants/error_handling.dart';
import 'package:aka_mercado/constants/global_variables.dart';
import 'package:aka_mercado/constants/utils.dart';
import 'package:aka_mercado/features/home/screens/home_screen.dart';
import 'package:aka_mercado/models/user.dart';
import 'package:aka_mercado/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  // registrar usuario
  void signUpUser ({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8', 
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'La cuenta ha sido creada! Ingrese con las mismas credenciales',
            );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString()); 
    }
  }

  // inicio de sesión
  void signInUser ({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {

      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8', 
        },
      );
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString()); 
    }
  }
}