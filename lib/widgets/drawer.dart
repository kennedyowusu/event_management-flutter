import 'dart:convert';

import 'package:event_management/model/event.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:event_management/constants/colors.dart';
import 'package:event_management/constants/images.dart';
import 'package:event_management/view/auth/login.dart';
import 'package:event_management/view/history.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late UserModel user;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  void fetchUser() {
    GetStorage box = GetStorage();
    String? userDataJson = box.read('user');

    if (userDataJson != null) {
      Map<String, dynamic> userData = jsonDecode(userDataJson);
      setState(() {
        user = UserModel.fromJson(userData);
      });
    } else {
      print('User data not found in storage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: ProjectColors.blackColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(profile),
                ),
                const SizedBox(height: 10),
                Text(
                  user.name!,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          drawerListStyle(context, 'Home', Icons.person, onTap: () {
            Navigator.pop(context);
          }),
          drawerListStyle(
            context,
            'History',
            Icons.settings,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryView(),
                ),
              );
            },
          ),
          const Divider(
            color: Colors.grey,
            indent: 16,
            endIndent: 16,
            height: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.logout_outlined,
              color: ProjectColors.primaryColor.withOpacity(0.5),
            ),
            title: const Text('Logout'),
            onTap: () {
              logUserOut(context);
            },
          ),
        ],
      ),
    );
  }

  ListTile drawerListStyle(BuildContext context, String title, IconData icon,
      {void Function()? onTap}) {
    return ListTile(
        leading: Icon(
          icon,
          color: ProjectColors.primaryColor.withOpacity(0.5),
        ),
        title: Text(
          title,
        ),
        onTap: onTap);
  }

  void logUserOut(BuildContext context) {
    GetStorage storage = GetStorage();
    storage.remove('user');
    storage.remove('token');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginView(),
      ),
    );
  }
}
