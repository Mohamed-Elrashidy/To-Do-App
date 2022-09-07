import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/textformat.dart';
import '../widgets/icon_title_row.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.payLoad}) : super(key: key);
  final String payLoad;
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  se() {
    print(Get.isDarkMode);
  }

  @override
  //this logic not understanded
  final color = Get.isDarkMode ? Colors.black : Colors.white;
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
          Column(
            children: [
              SizedBox(height: 10),
              Text(
                'Hello ,Mohamed',
                style: TextStyle(
                    color: color, fontSize: 26, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 10),
              Text(
                'You have a new reminder',
                style: TextStyle(
                    color: color, fontSize: 18, fontWeight: FontWeight.w300),
              ),
            ],
          ),
          //  const SizedBox(height: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(30),
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: primaryClr,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  iconTitleRow('Title', Icons.text_format),
                  SizedBox(height: 20),
                  smallText(_payload.toString().split('|')[0]),
                  SizedBox(height: 20),
                  iconTitleRow('Description', Icons.description),
                  SizedBox(height: 20),
                  smallText(_payload.toString().split('|')[1]),
                  SizedBox(height: 20),
                  iconTitleRow('Date', Icons.calendar_today),
                  SizedBox(height: 20),
                  smallText(_payload.toString().split('|')[2]),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
