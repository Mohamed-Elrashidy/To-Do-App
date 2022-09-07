import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import './ui/pages/notification_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(backgroundColor: Colors.teal, primaryColor: Colors.teal),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const NotificationScreen(
        payLoad: 'AAAAA|DDDD|FFF',
      ),
    );
  }
}
