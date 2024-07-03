import 'package:event_management/constants/colors.dart';
import 'package:flutter/material.dart';

class ProjectButton extends StatelessWidget {
  const ProjectButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.paddingHorizontal,
    this.paddingVertical,
    this.color,
    this.fontSize,
    this.width,
  });

  final VoidCallback onTap;
  final String? buttonText;
  final double? paddingHorizontal, fontSize, paddingVertical, width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: color ?? ProjectColors.blackColor,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal ?? 18,
          vertical: paddingVertical ?? 10,
        ),
        child: Center(
          child: Text(
            buttonText!,
            style: TextStyle(
              color: const Color(0xfff2f2f2),
              fontSize: fontSize ?? 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
