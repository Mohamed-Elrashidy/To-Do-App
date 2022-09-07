import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget smallText(String s) {
  return Text(
    s,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 14,
    ),
    maxLines: 10,
    textAlign: TextAlign.justify,
  );
}

Widget headingStyle(String s) {
  return Text(s,
      style: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode ? Colors.white : Colors.black)));
}

Widget subHeadingStyle(String s) {
  return Text(s,
      style: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode ? Colors.white : Colors.black)));
}

Widget titleStyle(String s) {
  return Text(s,
      style: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode ? Colors.white : Colors.black)));
}

Widget subTitleStyle(String s) {
  return Text(s,
      style: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Get.isDarkMode ? Colors.white : Colors.black)));
}

Widget bodyStyle(String s) {
  return Text(s,
      style: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Get.isDarkMode ? Colors.white : Colors.black)));
}

Widget body2Style(String s) {
  return Text(s,
      style: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Get.isDarkMode ? Colors.grey[200] : Colors.black)));
}
