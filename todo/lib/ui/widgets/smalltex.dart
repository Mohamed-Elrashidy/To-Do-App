import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
