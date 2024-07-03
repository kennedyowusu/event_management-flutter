import 'package:event_management/constants/colors.dart';
import 'package:event_management/utils/platform.dart';
import 'package:flutter/material.dart';

class AppLayout extends StatelessWidget {
  final Key? scaffoldKey;
  final PreferredSizeWidget? appBar;
  final bool showAppBar;
  final String? appBarTitle;
  final Widget? leftColumn;
  final Widget middleColumn;
  final Widget? rightColumn;
  final Color? backgroundColor;
  final bool showBorder;
  final bool showScreenShortcut;
  final Widget? floatingActionButton;
  final bool showWebMenu;
  final bool isDarkTheme;

  const AppLayout({
    super.key,
    this.appBar,
    this.leftColumn,
    required this.middleColumn,
    this.rightColumn,
    this.backgroundColor,
    this.showBorder = false,
    this.scaffoldKey,
    this.showScreenShortcut = false,
    this.showAppBar = false,
    this.appBarTitle,
    this.floatingActionButton,
    this.showWebMenu = false,
    this.isDarkTheme = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: DevicePlatform.isWeb == false && appBar != null ? appBar : null,
      body: SingleChildScrollView(
        child: Container(
          padding: MediaQuery.of(context).size.width > 1200
              ? const EdgeInsets.symmetric(horizontal: 100)
              : const EdgeInsets.symmetric(horizontal: 0),
          color: backgroundColor ??
              (isDarkTheme
                  ? const Color.fromARGB(255, 9, 9, 9)
                  : Colors.grey.shade100),
          child: Row(
            children: <Widget>[
              if (DevicePlatform.isWeb &&
                  MediaQuery.of(context).size.width > 768)
                Expanded(
                  flex: 3,
                  child: leftColumn ?? Container(),
                ),
              Expanded(
                  flex: 5,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        if (showAppBar && DevicePlatform.isWeb)
                          Container(
                            decoration: const BoxDecoration(
                              color: ProjectColors.whiteColor,
                              border: Border(
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: Color(0xFFE8E8E8),
                                ),
                              ),
                              // color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: 30,
                                      child: const Center(
                                        child: Icon(
                                          Icons.arrow_back_ios_new,
                                          color: ProjectColors.blackColor,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        appBarTitle ?? '',
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          // letterSpacing: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                              ],
                            ),
                          ),
                        Expanded(
                          child: Container(
                              decoration: showBorder == true
                                  ? BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                            width: 1.0,
                                            color: isDarkTheme
                                                ? const Color.fromARGB(
                                                    255, 35, 35, 35)
                                                : Colors.grey.shade100),
                                        right: BorderSide(
                                            width: 1.0,
                                            color: isDarkTheme
                                                ? const Color.fromARGB(
                                                    255, 35, 35, 35)
                                                : Colors.grey.shade100),
                                      ),
                                      // color: Colors.white,
                                    )
                                  : null,
                              child: middleColumn),
                        ),
                      ],
                    ),
                  )),
              if (DevicePlatform.isWeb &&
                  MediaQuery.of(context).size.width > 768)
                Expanded(flex: 3, child: rightColumn ?? Container())
            ],
          ),
        ),
      ),
    );
  }
}
