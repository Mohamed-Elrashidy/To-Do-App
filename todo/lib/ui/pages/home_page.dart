import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/widgets/textformat.dart';
import 'package:todo/services/theme_services.dart';
import 'notification_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

/* const NotificationScreen(
        payLoad: 'AAAAA|DDDD|FFF',
      ), */
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: context.theme.backgroundColor,
          leading: IconButton(
              onPressed: () {
                ThemeServices().switchTheme();
                Get.to(const NotificationScreen(
                  payLoad: 'AAAAA|DDDD|FFF',
                ));
              },
              icon: const Icon(Icons.arrow_back_ios)),
          elevation: 0,
          title: headingStyle('HomePage')),
      body: Container(),
    );
  }
}
