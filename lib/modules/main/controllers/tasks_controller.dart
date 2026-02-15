import 'package:flutter/material.dart';
import 'package:gamified_todo_app/modules/main/model/task_model.dart';
import 'package:get/get.dart';

class TasksController extends GetxController {
  //
  final taskCategory = ['today', 'upcomming', 'completed'];

  var selectedCategoryIndex = 0.obs;
  var selectedCategory = ''.obs;

  void updateColour(int categoryIndex) {
    selectedCategoryIndex.value = categoryIndex;
    selectedCategory.value = taskCategory[categoryIndex];
  }

  RxList<Map<String, dynamic>> lstTask = <Map<String, dynamic>>[
    {
      'title': 'Build Flutter Projects',
      'description': 'Build homescreen and taskscreen',
      'due': 'Tuesday, 2:22 pm',
      'xp': '20',
      'type': 'upcomming',
    },
    {
      'title': 'Build Projects',
      'description': 'Spring boot Project',
      'due': 'Tuesday, 2:45 pm',
      'xp': '40',
      'type': 'upcomming',
    },
    {
      'title': 'Learn PHP Laravel',
      'description': 'Crud Laravel',
      'due': 'Wednesday, 7:00 am',
      'xp': '80',
      'type': 'upcomming',
    },
    {
      'title': 'Learn Flutter on Udemy',
      'description': 'Add Xp to Card',
      'due': 'Wednesday, 7:00 am',
      'xp': '45',
      'type': 'today',
    },
    {
      'title': 'Drink Coffee',
      'description': 'Hot Late with less sugur',
      'due': '10:00 am, Saturday',
      'xp': '37',
      'type': 'today',
    },
    {
      'title': 'Go to Koh Kong',

      'description': 'Koh Kong and Visite Ji Phat and ta Barang Beach',
      'due': '7:10 am, Mondays',
      'xp': '67',
      'type': 'completed',
    },
  ].obs;

  // Add-Task Method
  void addTask({required TaskModel task}) {
    lstTask.add({
      'title': task.title,
      'description': task.description,
      'due': task.due,
      'xp': task.xp,
      'type': task.type,
    });
  }

  // updated-task
  void updateTask(int index, TaskModel task) {
    lstTask[index] = {
      'title': task.title,
      'description': task.description,
      'due': task.due,
      'xp': task.xp,
      'type': task.type,
    };
    lstTask.refresh();
  }

  void deletedTask(int index) {
    Get.defaultDialog(
      title: 'Delete',
      middleText: 'Are you sure that you wanna delete task? ',
      textCancel: 'Cancel',
      textConfirm: 'Delete',
      titleStyle: TextStyle(
        color: Colors.red,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      onConfirm: () {
        Get.back();
        if (index >= 0 && index < lstTask.length) {
          lstTask.removeAt(index);
          lstTask.refresh();
        }
      },
    );
  }

  // Filter Task
  List<Map<String, dynamic>> get filteredTasks {
    return lstTask
        .asMap()
        .entries
        .where((entry) {
          final task = TaskModel.fromMap(entry.value);
          return task.type == selectedCategory.value;
        })
        .map((entry) {
          return {...entry.value, '_index': entry.key};
        })
        .toList();
  }
}
