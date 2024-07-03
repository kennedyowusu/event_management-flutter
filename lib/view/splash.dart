import 'package:event_management/constants/colors.dart';
import 'package:event_management/view/auth/login.dart';
import 'package:event_management/view/home.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SplashView extends StatefulWidget {
  static const routeName = '/';
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final GetStorage getStorage = GetStorage();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      final String token = getStorage.read('token') ?? '';
      if (token.isNotEmpty) {
        Navigator.pushReplacementNamed(context, HomeView.routeName);
      } else {
        Navigator.pushReplacementNamed(context, LoginView.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: width * 0.5,
          height: height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Events Management',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.05),
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
              SizedBox(height: height * 0.05),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
