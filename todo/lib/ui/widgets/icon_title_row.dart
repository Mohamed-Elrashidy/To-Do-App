import 'package:flutter/material.dart';

Widget iconTitleRow(String s, IconData icon) {
  return Row(
    children: [
      Icon(
        icon,
        size: 35,
        color: Colors.white,
      ),
      const SizedBox(
        width: 15,
      ),
      Text(s,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ))
    ],
  );
}
