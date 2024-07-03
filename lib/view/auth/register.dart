import 'dart:convert';

import 'package:event_management/constants/colors.dart';
import 'package:event_management/constants/sizes.dart';
import 'package:event_management/network_helpers/http_service.dart';
import 'package:event_management/utils/platform.dart';
import 'package:event_management/utils/validations.dart';
import 'package:event_management/view/auth/login.dart';
import 'package:event_management/view/home.dart';
import 'package:event_management/widgets/buttons/project_button.dart';
import 'package:event_management/widgets/decorations.dart';
import 'package:event_management/widgets/layout/project_layout.dart';
import 'package:event_management/widgets/feedback/feedback_message.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class RegisterView extends StatefulWidget {
  static const routeName = '/register';
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _regKey = GlobalKey<FormState>();
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void register() async {
    setState(() {
      processing = true;
    });

    if (_regKey.currentState!.validate()) {
      try {
        HttpService httpService = HttpService();

        Map<String, dynamic> userData = {
          "name": _nameController.text.trim(),
          "email": _emailController.text.trim(),
          "password": _passwordController.text,
          "password_confirmation": _confirmPasswordController.text,
        };

        Map<String, dynamic> response = await httpService.signUserUp(userData);

        if (response['status'] == "success") {
          setState(() {
            processing = false;
          });

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

      FeedbackMessage.showSnackBar(context, "Please fill all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;

    return Form(
      key: _regKey,
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
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Name';
                        } else {
                          bool validName =
                              Validators().validateName(value.trim());
                          if (validName == false) {
                            return 'Please enter a valid Name';
                          }
                        }
                        return null;
                      },
                      decoration: CustomInputDecorator.textFieldStyle(
                        label: 'Full Name',
                        dense: true,
                      ),
                    ),
                    const SizedBox(height: 30.0),
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
                    TextFormField(
                      controller: _confirmPasswordController,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please confirm your Password';
                        }

                        if (_passwordController.text != input) {
                          return 'Passwords do not match';
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
                        label: 'Confirm Password',
                        dense: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    processing
                        ? const CircularProgressIndicator()
                        : ProjectButton(
                            width: double.infinity,
                            buttonText: "Sign Up",
                            onTap: () {
                              if (_regKey.currentState!.validate()) {
                                register();
                              } else {
                                FeedbackMessage.showSnackBar(
                                    context, 'Sign Up failed!');
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
                          "Already have an account?",
                          style: TextStyle(
                            color: ProjectColors.greyColor,
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              color: ProjectColors.blackColor,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginView(),
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
