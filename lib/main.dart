import 'package:connectivity/connectivity.dart';
import 'package:event_management/view/auth/login.dart';
import 'package:event_management/view/auth/register.dart';
import 'package:event_management/view/home.dart';
import 'package:event_management/view/no_internet.dart';
import 'package:event_management/view/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  await GetStorage.init();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hasInternetConnection = true;
  String message = 'Check your Internet Connection';

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    setState(() {
      hasInternetConnection = connectivityResult != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Event Management',
      debugShowCheckedModeBanner: false,
      initialRoute: hasInternetConnection
          ? SplashView.routeName
          : NoInternetScreen.routeName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        SplashView.routeName: (context) => const SplashView(),
        NoInternetScreen.routeName: (context) => const NoInternetScreen(
              message: "No Internet Connection",
            ),
        LoginView.routeName: (context) => const LoginView(),
        RegisterView.routeName: (context) => const RegisterView(),
        HomeView.routeName: (context) => const HomeView(),
      },
    );
  }
}
