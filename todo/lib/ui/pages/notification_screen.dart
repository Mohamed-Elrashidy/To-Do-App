import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.payLoad}) : super(key: key);
  final String payLoad;
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  final color = Get.isDarkMode ? Colors.white : darkGreyClr;
  late String _payload;
  @override
  void initState() {
    super.initState();
    _payload = widget.payLoad;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios)),
        elevation: 0,
        title: Text(
          _payload.toString().split('|')[0],
          style: TextStyle(color: color),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Text(
            'Hello ,Mohamed',
            style: TextStyle(
                color: color, fontSize: 26, fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 10),
          Text(
            'You have a new reminder',
            style: TextStyle(
                color: color, fontSize: 18, fontWeight: FontWeight.w300),
          ),
        ],
      )),
    );
  }
}
