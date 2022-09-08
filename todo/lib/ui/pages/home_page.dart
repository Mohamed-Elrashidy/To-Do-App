import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';
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
    SizeConfig().init(context);
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
          title: Text('HomePage', style: headingStyle())),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
        child: Column(
          children: [
            MyButton(label: 'Add Task', onTap: () {}),
            SizedBox(height: 100),
            InputField(title: "Task Title", hint: "Enter task title")
          ],
        ),
      ))),
    );
  }
}
