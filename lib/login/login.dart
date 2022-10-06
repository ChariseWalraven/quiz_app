import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../helpers/app_constants.dart';
import '../services/auth.dart';
import 'login_button.dart';
import 'login_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final userEmailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<String> loginUser(BuildContext context) async {
    String errorMessage = "";

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      try {
        debugPrint("Button pressed, logging in user");
        await context.read<AuthService>().loginUser(
              userEmailController.text,
              passwordController.text,
            );
        debugPrint('Login successful');
      } on Exception catch (e) {
        debugPrint('Login Unsuccesful. $e');
        errorMessage = "e";
      }
    }
    return errorMessage;
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
                String errorMessage = await loginUser(context);
                if (errorMessage.isEmpty) {
                  // NOTE: How to fix?
                  // ignore: use_build_context_synchronously
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/topics', (route) => false);
                }
                // TODO: handle error
              },
              text: "Login",
              color: AppConstants.hexToColor(AppConstants.appPrimaryColorGreen),
            ),
            Flexible(
              child: LoginButton(
                icon: FontAwesomeIcons.userNinja,
                text: 'Continue as Guest',
                loginMethod: AuthService().anonymousLogin,
                color:
                    AppConstants.hexToColor(AppConstants.appPrimaryColorGreen),
              ),
            ),
            LoginButton(
              text: 'Sign in with Google',
              icon: FontAwesomeIcons.google,
              color:
                  AppConstants.hexToColor(AppConstants.appPrimaryColorAction),
              loginMethod: AuthService().googleLogin,
              // AuthService().googleLogin,
            ),
          ],
        ),
      ),
    );
  }
}


// remove for now to make space so can see buttons properly when keyboard is up
            // Stack(children: [
            //   Image.asset(
            //     "assets/images/flutterdevcamp2022_banner.png",
            //   ),
            //   Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Text(
            //       '#flutterdevcamp \nLondon \n${DateFormat.MMMMd().format(DateTime.now())} ',
            //       style: TextStyle(
            //         color: AppConstants.hexToColor(
            //             AppConstants.appPrimaryColorGreen),
            //         fontSize: 24,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
            // ]),
