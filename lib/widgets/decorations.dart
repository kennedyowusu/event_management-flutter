import 'package:event_management/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomInputDecorator {
  static InputDecoration textFieldStyle({
    String? hint,
    bool dense = false,
    TextStyle? hintStyle,
    String? label,
    Widget? leadingIcon,
    Widget? trailingIcon,
    String? errorText,
    TextStyle? errorStyle,
    EdgeInsetsGeometry? contentPadding,
    TextStyle? labelStyle,
    int maxLines = 1,
  }) {
    return InputDecoration(
      prefixIcon: leadingIcon,
      suffixIcon: trailingIcon,
      hintText: hint,
      hintStyle: hintStyle,
      labelText: label,
      helperMaxLines: maxLines,
      labelStyle: const TextStyle(
        color: ProjectColors.greyColor,
      ),
      errorText: errorText,
      errorStyle: errorStyle,
      isDense: dense,
      contentPadding: contentPadding,
      fillColor: Colors.grey[100],
      filled: true,
      border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ProjectColors.black12Color,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(3.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: ProjectColors.black12Color,
              width: 1.0,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(3.0)),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: ProjectColors.black12Color,
            width: 1.0,
            style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}
