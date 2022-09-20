//import 'dart:js';

import 'package:flutter/material.dart';
import '../theme.dart';

AppBar appBar(var context, var onTap, Icon icon) {
  return AppBar(
    elevation: 0,
    backgroundColor: context.theme.backgroundColor,
    leading: IconButton(onPressed: () => onTap(), icon: icon),
    actions: const [
      CircleAvatar(
        backgroundImage: AssetImage('images/person.jpeg'),
        radius: 18,
      )
    ],
  );
}
