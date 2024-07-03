import 'package:connectivity/connectivity.dart';
import 'package:event_management/constants/colors.dart';
import 'package:event_management/view/auth/login.dart';
import 'package:event_management/view/home.dart';
import 'package:event_management/widgets/buttons/project_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

class NoInternetScreen extends StatelessWidget {
  static const routeName = '/no-internet';
  final String message;

  const NoInternetScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.wifi_off,
                  size: 200,
                  color: ProjectColors.blackColor,
                ),
                const SizedBox(height: 26),
                Text(
                  message.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ProjectButton(
                  buttonText: 'Refresh',
                  fontSize: 20.0,
                  onTap: () {
                    checkInternetConnectivity(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> checkInternetConnectivity(BuildContext context) async {
  ConnectivityResult connectivityResult =
      await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    Fluttertoast.showToast(
      msg: 'Still no internet connection',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  } else {
    Fluttertoast.showToast(
      msg: 'Internet connection restored',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );

    final GetStorage box = GetStorage();
    final userData = box.read('user') ?? '';

    if (userData.isNotEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginView(),
        ),
      );
    }
  }
}
