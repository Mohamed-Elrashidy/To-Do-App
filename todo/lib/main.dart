import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/services/notification_services.dart';
import 'package:todo/ui/pages/home_page.dart';
import './ui/pages/notification_screen.dart';
import './ui/theme.dart';
import 'services/theme_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // NotifyHelper().initializationNotification();
  await DBHelper.initDb();
  await GetStorage.init();
  ThemeServices().switchTheme();
  var result = DBHelper.query();
  print(result);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeServices().theme,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: const HomePage());
  }
}
