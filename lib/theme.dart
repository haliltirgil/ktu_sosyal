import 'package:flutter/material.dart';

class KtuTextStyles {
  const KtuTextStyles();

  static const TextStyle lightBlack = const TextStyle(
      color: Colors.black, fontFamily: 'Rubik', fontWeight: FontWeight.w300);
  static const TextStyle regularBlack =
      const TextStyle(fontFamily: 'Rubik', fontWeight: FontWeight.w500);
  static const TextStyle boldBlack = const TextStyle(
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontSize: 13);
  static const TextStyle boldBig = const TextStyle(
      fontFamily: 'Rubik', fontWeight: FontWeight.w600, fontSize: 20);

  static const TextStyle lightBlue = const TextStyle(
      color: KtuColors.ktuLightBlue,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w300);
  static const TextStyle regularBlue = const TextStyle(
      color: KtuColors.ktuLightBlue,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w500);
  static const TextStyle boldBlue = const TextStyle(
      color: KtuColors.ktuLightBlue,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w600);

  static const TextStyle light =
      const TextStyle(fontFamily: 'Rubik', fontWeight: FontWeight.w300);
  static const TextStyle regular =
      const TextStyle(fontFamily: 'Rubik', fontWeight: FontWeight.w400);
  static const TextStyle bold =
      const TextStyle(fontFamily: 'Rubik', fontWeight: FontWeight.w600);

  static const TextStyle lightWhite = const TextStyle(
      color: Colors.white, fontFamily: 'Rubik', fontWeight: FontWeight.w300);
  static const TextStyle regularWhite = const TextStyle(
      color: Colors.white, fontFamily: 'Rubik', fontWeight: FontWeight.w500);
  static const TextStyle boldWhite = const TextStyle(
      color: Colors.white, fontFamily: 'Rubik', fontWeight: FontWeight.w600);
}

class KtuColors {
  const KtuColors();

  static const ktuLightBlue = const Color(0xFF005AA9);
  static const ktuWhite = const Color(0xFFFBFCFF);
  static const loginSignUpColor = const Color(0xFF005AAF);
  static const ktuLineColor = const Color(0xFFBDBDBD);
  static const ktuDarkBlue = const Color(0xFF003C63);
  static const ktuGradientStart = const Color(0xFF004FFF);
  static const ktuGradientEnd = const Color(0xFF2569F8);
  static const gradientLogin = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [ktuLightBlue, ktuGradientEnd]);
}

class LogoConstants {
  static const String appBarLogo = 'assets/svg/appbar_logo.svg';
  static const String drawerIcon = 'assets/svg/drawer_icon.svg';
  static const String messageIcon = 'assets/svg/message_icon.svg';
  static const String ktuLogo = 'assets/svg/ktu_logo.svg';
  static const String groupIcon = 'assets/svg/group_icon.svg';
  static const String homeIcon = 'assets/svg/home_icon.svg';
  static const String notificationIcon = 'assets/svg/notification_icon.svg';
  static const String searchIcon = 'assets/svg/search_icon.svg';
  static const String profileIcon = 'assets/svg/profile_icon.svg';
  static const String profileIcon2 = 'assets/svg/profile_icon2.svg';
  static const String communityIcon = 'assets/svg/community_icon.svg';
  static const String settingsIcon = 'assets/svg/settings_icon.svg';
  static const String helpIcon = 'assets/svg/help_icon.svg';
  static const String logoutIcon = 'assets/svg/logout_icon.svg';
  static const String notFound = 'assets/svg/404-page-not-found.svg';
}
