import 'dart:convert';
import 'package:event_management/constants/colors.dart';
import 'package:event_management/constants/sizes.dart';
import 'package:event_management/network_helpers/http_service.dart';
import 'package:event_management/utils/platform.dart';
import 'package:event_management/utils/validations.dart';
import 'package:event_management/view/auth/register.dart';
import 'package:event_management/view/home.dart';
import 'package:event_management/widgets/buttons/project_button.dart';
import 'package:event_management/widgets/decorations.dart';
import 'package:event_management/widgets/layout/project_layout.dart';
import 'package:event_management/widgets/feedback/feedback_message.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LoginView extends StatefulWidget {
  static const routeName = '/login';
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  bool processing = false;
  bool _showPassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login() async {
    setState(() {
      processing = true;
    });

    if (loginKey.currentState!.validate()) {
      try {
        HttpService httpService = HttpService();

        Map<String, dynamic> userData = {
          "email": _emailController.text.trim(),
          "password": _passwordController.text,
        };

        Map<String, dynamic> response = await httpService.loginUser(userData);

        if (response['status'] == "success") {
          final GetStorage box = GetStorage();

          String encodedUserData = json.encode(response['user']);
          box.write('user', encodedUserData);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return const HomeView();
              },
            ),
          );
        } else {
          setState(() {
            processing = false;
          });

          FeedbackMessage.showSnackBar(context, response['message']);
        }
      } catch (e) {
        setState(() {
          processing = false;
        });

        FeedbackMessage.showSnackBar(
            context, "Something went wrong, please try again!");
      }
    } else {
      setState(() {
        processing = false;
      });

      FeedbackMessage.showSnackBar(context, "please fill all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;

    return Form(
      key: loginKey,
      child: AppLayout(
        scaffoldKey: _scaffoldKey,
        backgroundColor: Colors.grey.shade100,
        middleColumn: Container(
          width: double.infinity,
          color: ProjectColors.whiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: ProjectColors.greyColor.withOpacity(0.5),
                child: const Text(
                  "EV",
                  style: TextStyle(
                    color: ProjectColors.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: mediaQueryHeight * 0.02),
              Container(
                width: 350,
                padding: const EdgeInsets.fromLTRB(30, 60, 30, 10),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Email Address';
                        } else {
                          bool validEmail =
                              Validators().validateEmail(value.trim());
                          if (validEmail == false) {
                            return 'Please enter a valid Email Address';
                          }
                        }
                        return null;
                      },
                      decoration: CustomInputDecorator.textFieldStyle(
                        label: 'Email Address',
                        dense: true,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    TextFormField(
                      controller: _passwordController,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please enter your Password';
                        }
                        return null;
                      },
                      obscureText: _showPassword,
                      decoration: CustomInputDecorator.textFieldStyle(
                        trailingIcon: GestureDetector(
                          onTap: _togglePasswordVisibility,
                          child: _showPassword
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                        label: 'Password',
                        dense: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    processing
                        ? const CircularProgressIndicator()
                        : ProjectButton(
                            width: double.infinity,
                            buttonText: "Sign In",
                            onTap: () {
                              if (loginKey.currentState!.validate()) {
                                login();
                              } else {
                                FeedbackMessage.showSnackBar(
                                    context, 'Sign in failed!');
                              }
                            },
                            fontSize: DevicePlatform.isWeb == true
                                ? ProjectFontSizes.fourteen
                                : ProjectFontSizes.eighteen,
                          ),
                    const SizedBox(height: 40),
                    const Divider(
                      color: ProjectColors.greyColor,
                    ),
                    Row(
                      children: <Widget>[
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: ProjectColors.greyColor,
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: ProjectColors.blackColor,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterView(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
}
