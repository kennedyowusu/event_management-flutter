import 'package:flutter/material.dart';

const kMultiplier = 0.0012;
const kMultiplierHalf = 0.0006;
const kFS10 = 10.0 * kMultiplier;
const kFS11 = 11.0 * kMultiplier;
const kFS12 = 12.0 * kMultiplier;
const kFS13 = 13.0 * kMultiplier;
const kFS14 = 14.0 * kMultiplier;
const kFS16 = 16.0 * kMultiplier;
const kFS17 = 17.0 * kMultiplier;
const kFS18 = 18.0 * kMultiplier;
const kFS20 = 20.0 * kMultiplier;
const kFS22 = 22.0 * kMultiplier;
const kFS24 = 24.0 * kMultiplier;
const kFS26 = 26.0 * kMultiplier;
const kFS28 = 28.0 * kMultiplier;
const kFS30 = 30.0 * kMultiplier;
const kFS32 = 32.0 * kMultiplier;
const kFS34 = 34.0 * kMultiplier;
const kFS36 = 36.0 * kMultiplier;
const kFS38 = 38.0 * kMultiplier;

const kBackgroundColor = Color(0xFFE2E2E2);
const kEvermatesWhiteColor = Color(0xFFFFFFFF);
const kEvermatesOffWhiteColor = Color(0xFFFDFDFD);
const kEvermatesGreyColor = Color(0xFF808080);
const kEvermatesGreyPewterColor = Color(0xFF999DA0);
const kEvermatesGreyLightColor = Color(0xFFD9D9D9);
const kEvermatesGreyLighterColor = Color(0xFFF2F2F2);
const kEvermatesBlackColor = Color(0xFF262626);

const kBigTitleFontStyle = TextStyle(
  color: Color(0xFF1B1B1B),
  fontSize: 18.0,
  fontWeight: FontWeight.w600,
  fontStyle: FontStyle.normal,
);

const kBigScreenHeight = 800;
const kMediumScreenHeight = 670;

const double mobileBreakpoint = 375;
const double tabletBreakpoint = 768;
const double laptopBreakpoint = 992;
const double desktopBreakpoint = 1200;

class Constant {
  static double size(double mediaQueryHeight, double onSmallScreen,
      double onMediumScreen, double onBigScreen) {
    return mediaQueryHeight <= kMediumScreenHeight
        ? onSmallScreen * mediaQueryHeight
        : mediaQueryHeight <= kBigScreenHeight
            ? onMediumScreen * mediaQueryHeight
            : onBigScreen * mediaQueryHeight;
  }

  static double kSize(double mediaQueryHeight, double onSmallScreen,
      double onMediumScreen, double onBigScreen) {
    return mediaQueryHeight <= kMediumScreenHeight
        ? (onSmallScreen * kMultiplier) * mediaQueryHeight
        : mediaQueryHeight <= kBigScreenHeight
            ? (onMediumScreen * kMultiplier) * mediaQueryHeight
            : (onBigScreen * kMultiplier) * mediaQueryHeight;
  }

  static defaultFontSize(double mediaQueryHeight) {
    return mediaQueryHeight <= kMediumScreenHeight
        ? 16 * 1.2
        : mediaQueryHeight <= kBigScreenHeight
            ? 16 * 1.4
            : 16 * 1.6;
  }
}

class ProjectFontSizes {
  static const double twentyFour = 24;
  static const double twentyTwo = 22;
  static const double twenty = 20;
  static const double eighteen = 18;
  static const double seventeen = 17;
  static const double sixteen = 16;
  static const double fifteen = 15;
  static const double fourteen = 14;
  static const double thirteen = 13;
  static const double twelve = 12;
}
