import 'package:event_management/constants/colors.dart';
import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({
    super.key,
    this.titleText,
    this.subTitleText,
    this.actions,
    required this.backgroundColor,
    this.onPressed,
    this.iconSize,
    this.toolbarHeight,
    this.elevation,
    this.isLeading,
    required this.context,
    this.leadingWidth,
    this.padding,
    this.bottom,
  });

  final String? titleText;
  final String? subTitleText;
  final actions;
  final Color backgroundColor;
  final VoidCallback? onPressed;
  final double? iconSize;
  final double? toolbarHeight;
  final double? elevation;
  final bool? isLeading;
  final BuildContext context;
  final double? leadingWidth;
  final EdgeInsetsGeometry? padding;
  final bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation ?? 0.3,
      backgroundColor: backgroundColor,
      toolbarHeight: toolbarHeight ?? 100,
      centerTitle: true,
      leadingWidth: 54,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: ProjectColors.blackColor,
          size: 20.0,
        ),
        onPressed: onPressed ??
            () {
              Navigator.pop(this.context);
            },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleText != null
                  ? Text(
                      titleText!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        color: ProjectColors.blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Container(),
              if (subTitleText != null)
                Container(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Text(
                    subTitleText!,
                    style: const TextStyle(
                      color: ProjectColors.greyColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      actions: actions,
      bottom: bottom,
    );
  }
}
