import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/shared/error.dart';

import '../helpers/app_constants.dart';
import '../services/auth.dart';
import 'login_button.dart';
import 'login_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final userEmailController = TextEditingController();
  final passwordController = TextEditingController();
  String errorMessage = "";

  Future<bool> loginUser(BuildContext context) async {
    bool isSuccess = false;

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      try {
        debugPrint("Button pressed, logging in user");
        await context.read<AuthService>().loginUser(
              userEmailController.text,
              passwordController.text,
            );
        debugPrint('Login successful');
        isSuccess = true;
      } on Exception catch (e) {
        debugPrint('Login Unsuccesful. $e');
        setState(() {
          errorMessage = e.toString();
        });
      }
    }

    return isSuccess;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  if (errorMessage.isNotEmpty)
                    ErrorMessage(
                      message: errorMessage,
                    ),
                  LoginTextField(
                    hintText: "Enter your email",
                    validator: ((value) {
                      if (value != null &&
                          value.isNotEmpty &&
                          value.length < 5) {
                        return "Your email should be more than 5 characters";
                      } else if (value != null && value.isEmpty) {
                        return "Please enter your email";
                      } else if (value != null && !value.contains("@")) {
                        return "This email is invalid";
                      }
                      return null;
                    }),
                    textEditingController: userEmailController,
                  ),
                  const SizedBox(height: 24),
                  LoginTextField(
                    validator: ((value) {
                      if (value != null &&
                          value.isNotEmpty &&
                          value.length < 5) {
                        return "Your email should be more than 5 characters";
                      } else if (value != null && value.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    }),
                    textEditingController: passwordController,
                    obscureText: true,
                    hintText: 'Enter your password',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            LoginButton(
              icon: FontAwesomeIcons.envelope,
              loginMethod: () async {
                bool isSuccess = await loginUser(context);
                if (isSuccess) {
                  // NOTE: How to fix?
                  // ignore: use_build_context_synchronously
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/topics', (route) => false);
                }
              },
              text: "Login",
              color: AppConstants.hexToColor(AppConstants.appPrimaryColorGreen),
            ),
            // TODO: implement anonymous sign in?
            LoginButton(
              text: 'Sign in with Google',
              icon: FontAwesomeIcons.google,
              color:
                  AppConstants.hexToColor(AppConstants.appPrimaryColorAction),
              loginMethod: AuthService().googleLogin,
            ),
          ],
        ),
      ),
    );
  }
}
