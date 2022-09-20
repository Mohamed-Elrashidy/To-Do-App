import 'package:get/state_manager.dart';
import 'package:todo/db/db_helper.dart';
import 'package:get/get.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  static final taskList = <Task>[].obs();
  Future<int> addTask({Task? task}) {
    return DBHelper.insert(task);
  }

  getTasks() async {
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromjson(data)).toList());
    print('start size ${taskList.length}');
  }

  void deleteTasks(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  void deleteAllTasks() async {
    await DBHelper.deleteAll();
    getTasks();
  }

  void markAsCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
