import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';
import 'package:todo/ui/widgets/textformat.dart';
import '../../models/task.dart';
import '../widgets/appbar.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String _selectedDate = DateFormat.yMd().format(DateTime.now());
  String _startTime = DateFormat("hh:mm a").format(DateTime.now());
  String _endTime = DateFormat("hh:mm a")
      .format(DateTime.now().add(Duration(minutes: 15)))
      .toString();
  String _dayName = DateFormat('EEEE').format(DateTime.now());
  String _dayNumber = DateFormat('d').format(DateTime.now()).toString();

  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'none';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        leading: IconButton(
          color: Colors.grey,
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 24,
        ),
        elevation: 0,
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('images/person.jpeg'),
            radius: 18,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Add Task',
                style: headingStyle(),
              ),
              InputField(
                title: 'Title',
                hint: 'Add title here',
                controller: _titleController,
              ),
              InputField(
                title: 'Note',
                hint: 'Add note here',
                controller: _noteController,
              ),
              InputField(
                title: 'Date',
                hint: _selectedDate,
                widget: IconButton(
                  icon: Icon(Icons.calendar_today_outlined),
                  color: Colors.grey,
                  onPressed: () => _getDateFromUser(),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: InputField(
                          title: 'Start time',
                          hint: _startTime,
                          widget: IconButton(
                            icon: Icon(Icons.access_alarm_rounded),
                            color: Colors.grey,
                            onPressed: () =>
                                _getTimeFromUser(isStartTime: true),
                          ))),
                  Expanded(
                      child: InputField(
                          title: 'End time',
                          hint: _endTime,
                          widget: IconButton(
                            icon: Icon(Icons.access_alarm_rounded),
                            color: Colors.grey,
                            onPressed: () =>
                                _getTimeFromUser(isStartTime: false),
                          ))),
                ],
              ),
              InputField(
                  title: 'Reminder',
                  hint: '$_selectedRemind minutes early',
                  widget: DropdownButton(
                      icon: const Icon(Icons.keyboard_arrow_down),
                      underline: Container(height: 0),
                      dropdownColor: Colors.blueGrey,
                      items: remindList
                          .map<DropdownMenuItem<String>>(
                              (int value) => DropdownMenuItem(
                                  value: value.toString(),
                                  child: Text(
                                    '$value',
                                    style: const TextStyle(color: Colors.white),
                                  )))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRemind = int.parse(newValue!);
                        });
                      })),
              InputField(
                  title: 'Rpeat',
                  hint: '$_selectedRepeat ',
                  widget: DropdownButton(
                      icon: const Icon(Icons.keyboard_arrow_down),
                      underline: Container(height: 0),
                      dropdownColor: Colors.blueGrey,
                      items: repeatList
                          .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    '$value',
                                    style: const TextStyle(color: Colors.white),
                                  )))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRepeat = newValue!;
                        });
                      })),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorPallete(),
                  MyButton(
                      label: 'Create Task',
                      onTap: () {
                        _validateData();
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Column _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: titleStyle(),
        ),
        Wrap(
          children: List<Widget>.generate(3, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                  child: CircleAvatar(
                    child: (index == _selectedColor)
                        ? const Icon(Icons.done)
                        : Container(),
                    backgroundColor: index == 0
                        ? primaryClr
                        : index == 1
                            ? pinkClr
                            : orangeClr,
                  ),
                  padding: const EdgeInsets.only(left: 8)),
            );
          }),
        )
      ],
    );
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTasksTodb();
      Get.back();
    } else if (_titleController.text.isEmpty && _noteController.text.isEmpty) {
      Get.snackbar('required', 'You must add title and note',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white,
          colorText: pinkClr,
          icon: Icon(Icons.warning_amber_rounded, color: Colors.red));
    } else if (_titleController.text.isEmpty) {
      Get.snackbar('required', 'You must add title',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white,
          colorText: pinkClr,
          icon: Icon(Icons.warning_amber_rounded, color: Colors.red));
    } else if (_noteController.text.isEmpty) {
      Get.snackbar('required', 'You must add note',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white,
          colorText: pinkClr,
          icon: Icon(Icons.warning_amber_rounded, color: Colors.red));
    }
  }

  Future<void> _addTasksTodb() async {
    int value = await _taskController.addTask(
      task: Task(
        title: _titleController.text,
        note: _noteController.text,
        isCompleted: 0,
        date: _selectedDate,
        startTime: _startTime,
        endTime: _endTime,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
        color: _selectedColor,
        day: (_selectedRepeat == 'Weekly') ? _dayName : _dayNumber,
      ),
    );
    _taskController.getTasks();

    print(value);
  }

  _getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(20100),
    );
    setState(() {
      if (_pickedDate != null) {
        _dayName = DateFormat('EEEE').format(_pickedDate);
        _dayNumber = DateFormat('d').format(_pickedDate).toString();
        _selectedDate = DateFormat.yMd().format(_pickedDate);
      }
    });
  }

  _getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? _pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.now()
          : TimeOfDay.fromDateTime(DateTime.now().add(Duration(minutes: 15))),
    );
    if (_pickedTime != null) {
      String? _formatetedTime = _pickedTime.format(context);
      setState(() {
        {
          isStartTime
              ? _startTime = _formatetedTime
              : _endTime = _formatetedTime;
        }
      });
    }
  }
}
