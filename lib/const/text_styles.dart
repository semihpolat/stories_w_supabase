import 'package:flutter/material.dart';

abstract class TextStyles {
  static TextStyle get homeQuote {
    return TextStyle(
        color: Colors.white, fontWeight: FontWeight.w200, fontSize: 45.0);
  }

  static TextStyle get frameMenu {
    return TextStyle(
        color: Colors.white, fontWeight: FontWeight.w300, fontSize: 20.0);
  }

  static TextStyle get frameMenuB {
    return TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 25.0,
    );
  }

  static TextStyle get frameMenuBR {
    return TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w300,
      fontSize: 22.0,
    );
  }

  static TextStyle get chatTitle {
    return TextStyle(
        color: Colors.black, fontWeight: FontWeight.w600, fontSize: 40.0);
  }

  static TextStyle get profileName {
    return TextStyle(
        color: Colors.black, fontWeight: FontWeight.w600, fontSize: 40.0);
  }

  static TextStyle get profileBio {
    return TextStyle(
        color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15.0);
  }

  static TextStyle get profileHeader {
    return TextStyle(
        color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22.0);
  }

  static TextStyle get homeH {
    return TextStyle(
        color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18.0);
  }

  static TextStyle get homeP {
    return TextStyle(
        color: Colors.black, fontWeight: FontWeight.w800, fontSize: 15.0);
  }
}
