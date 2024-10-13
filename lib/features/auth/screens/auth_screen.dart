import 'package:aka_mercado/common/widgets/custom_button.dart';
import 'package:aka_mercado/common/widgets/custom_textfield.dart';
import 'package:aka_mercado/constants/global_variables.dart';
import 'package:aka_mercado/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                'Bienvenido a AKÁ Mercado',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ListTile(
                tileColor: _auth == Auth.signup
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Registrar Cuenta',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signup)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextfield(
                          controller: _nameController,
                          hintText: 'Usuario',
                        ),
                        const SizedBox(height: 10),
                        CustomTextfield(
                          controller: _emailController,
                          hintText: 'E-mail',
                        ),
                        const SizedBox(height: 10),
                        CustomTextfield(
                          controller: _passwordController,
                          hintText: 'Contraseña',
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          text: 'Registrar',
                          onTap: () {
                            if(_signUpFormKey.currentState!.validate()) {
                              signUpUser();
                            }
                          },
                          backgroundColor: const Color(0xFFDC3545), // Danger color (rojo)
                          textColor: Colors.white, // Contrasting text color (blanco)
                        )
                      ],
                    ),
                  ),
                ), 
              ListTile(
                tileColor: _auth == Auth.signin
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signin,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signin)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextfield(
                          controller: _emailController,
                          hintText: 'E-mail',
                        ),
                        const SizedBox(height: 10),
                        CustomTextfield(
                          controller: _passwordController,
                          hintText: 'Contraseña',
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          text: 'Ingresar',
                          onTap: () {},
                          backgroundColor: const Color(0xFFDC3545), // Danger color (rojo)
                          textColor: Colors.white, // Contrasting text color (blanco)
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
