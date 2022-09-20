import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/ui/pages/add_task_page.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';
import 'package:todo/ui/widgets/task_tile.dart';
import 'package:todo/ui/widgets/textformat.dart';
import 'package:todo/services/theme_services.dart';
import '../../models/task.dart';
import 'notification_screen.dart';
import '../widgets/appbar.dart';
import '/services/notification_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  late NotifyHelper notifyHelper;
  var selectedDate = DateTime.now().obs();
  final TaskController _taskContorller = Get.put(TaskController());
  @override
  void initState() {
    super.initState();
    _taskContorller.getTasks();
    notifyHelper = NotifyHelper();
    notifyHelper.requestIOSPermissions;
    notifyHelper.initializeNotification();
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _taskContorller.getTasks();
    return Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: context.theme.backgroundColor,
          leading: IconButton(
            color: Get.isDarkMode ? Colors.white : darkGreyClr,
            onPressed: () {
              ThemeServices().switchTheme();
            },
            icon: Get.isDarkMode
                ? Icon(Icons.wb_sunny_rounded)
                : Icon(Icons.nightlight_round_outlined),
            iconSize: 24,
          ),
          actions: [
            IconButton(
                iconSize: 24,
                color: Get.isDarkMode ? Colors.white : darkGreyClr,
                onPressed: () => _taskContorller.deleteAllTasks(),
                icon: Icon(Icons.cleaning_services_rounded)),
            CircleAvatar(
              backgroundImage: AssetImage('images/person.jpeg'),
              radius: 18,
            )
          ],
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [_addTaskBar(), _addDatePicker(), _showTasks()],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  _addTaskBar() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat.yMMMMd().format(DateTime.now()),
            style: subHeadingStyle(),
          ),
          Text(
            'Today',
            style: subHeadingStyle(),
          )
        ],
      ),
      MyButton(
          label: '+ Add Task',
          onTap: () {
            Get.to(() => const AddTaskPage());
            _taskContorller.getTasks();
          })
    ]);
  }

  _addDatePicker() {
    return Container(
      height: 100,
      margin: EdgeInsets.only(top: 8, left: 8),
      child: DatePicker(DateTime.now(), width: 80, onDateChange: (newDate) {
        setState(() {
          selectedDate = newDate;
        });
      },
          initialSelectedDate: DateTime.now(),
          selectedTextColor: Colors.white,
          selectionColor: primaryClr,
          dateTextStyle: subHeadingStyle(),
          monthTextStyle: subHeadingStyle(),
          dayTextStyle: subHeadingStyle()),
    );
  }

  _showTasks() {
    _taskContorller.getTasks();
    return Flexible(child: Obx(() {
      if (TaskController.taskList.length == 0) {
        return _noTasksMSG();
      } else {
        return ListView.builder(
            scrollDirection: SizeConfig.orientation == Orientation.landscape
                ? Axis.horizontal
                : Axis.vertical,
            itemCount: TaskController.taskList.length,
            itemBuilder: (BuildContext context, int index) {
              final taskDate = TaskController.taskList[index].date;
              final dayName = DateFormat('EEEE').format(selectedDate);
              print(TaskController.taskList[index].day);
              print(DateFormat('d').format(selectedDate));
              print(DateFormat('EEEE').format(selectedDate));

              if ((selectedDate.compareTo(DateFormat.yMd()
                          .parse(TaskController.taskList[index].date!)) >=
                      0) &&
                  ((taskDate == DateFormat.yMd().format(selectedDate)) ||
                      (TaskController.taskList[index].repeat == 'Daily') ||
                      (TaskController.taskList[index].day == dayName &&
                          TaskController.taskList[index].repeat == 'Weekly') ||
                      (TaskController.taskList[index].repeat == 'Monthly' &&
                          TaskController.taskList[index].day ==
                              DateFormat('d').format(selectedDate)))) {
                var task = TaskController.taskList[index];
                var hour = task.startTime.toString().split(':')[0];
                var minutes = task.endTime.toString().split(':')[1];
                minutes = minutes.split(' ')[0];
                /*   if (DateTime.now()
                        .compareTo(DateFormat.yMd().parse(task.date!)) ==
                    0)*/
                {
                  print('here');
                  notifyHelper.scheduledNotification(
                      int.parse(hour), int.parse(minutes), task);
                }
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: Duration(milliseconds: 300),
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      duration: Duration(milliseconds: 300),
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet(
                              context, TaskController.taskList[index]);
                        },
                        child: TaskTile(task: TaskController.taskList[index]),
                      ),
                    ),
                  ),
                );
              } else {
                return Container(
                  height: 0,
                );
              }
            });
      }
    }));
  }

  _noTasksMSG() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Wrap(
            direction: SizeConfig.orientation == Orientation.landscape
                ? Axis.horizontal
                : Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              if (SizeConfig.orientation == Orientation.landscape)
                SizedBox(
                  height: 10,
                )
              else
                SizedBox(
                  height: 180,
                ),
              SvgPicture.asset(
                'images/task.svg',
                color: primaryClr.withOpacity(0.5),
                height: 100,
              ),
              Text(
                'There is no tasks \n Go to Add Task',
                style: subTitleStyle(),
              ),
              if (SizeConfig.orientation == Orientation.landscape)
                SizedBox(
                  height: 10,
                )
              else
                SizedBox(
                  height: 100,
                ),
            ],
          ),
        ),
      ],
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(Container(
      color: Get.isDarkMode ? darkGreyClr : Colors.white,
      width: double.infinity,
      height: (SizeConfig.orientation == Orientation.landscape)
          ? (task.isCompleted == 0)
              ? SizeConfig.screenHeight * 0.9
              : SizeConfig.screenHeight * 0.6
          : (task.isCompleted == 0)
              ? SizeConfig.screenHeight * 0.39
              : SizeConfig.screenHeight * 0.30,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 2,
              color: Get.isDarkMode ? Colors.grey : Colors.white,
            ),
            SizedBox(
              height: 20,
            ),
            (task.isCompleted == 0)
                ? _buildBottomSheet(
                    label: 'Task Completed',
                    onTap: () {
                      _taskContorller.markAsCompleted(task.id!);
                      Get.back();
                    })
                : Container(
                    height: 0,
                  ),
            _buildBottomSheet(
                clr: Colors.red,
                label: 'Delete',
                onTap: () {
                  _taskContorller.deleteTasks(task);
                  Get.back();
                }),
            SizedBox(height: 5),
            Container(
              height: 2,
              color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[400],
            ),
            SizedBox(height: 5),
            _buildBottomSheet(
                label: 'Cancel',
                onTap: () {
                  Get.back();
                }),
            SizedBox(height: 20),
          ],
        ),
      ),
    ));
  }

  _buildBottomSheet(
      {required String? label,
      required Function onTap,
      bool? isClosed,
      Color? clr}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        width: SizeConfig.screenWidth * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: clr != null ? clr : primaryClr),
        child: Text(label!, style: titleStyle().copyWith(color: Colors.white)),
      ),
    );
  }
}
