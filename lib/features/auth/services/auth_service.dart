import 'package:aka_mercado/constants/error_handling.dart';
import 'package:aka_mercado/constants/global_variables.dart';
import 'package:aka_mercado/constants/utils.dart';
import 'package:aka_mercado/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        token: ''
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
            'La cuenta ha sido creada! Ingrese con las mismas credenciales'
            );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString()); 
    }
  }
}