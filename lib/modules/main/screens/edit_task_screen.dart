import 'package:flutter/material.dart';
import 'package:gamified_todo_app/core/utils/date_picker.dart';

import 'package:gamified_todo_app/modules/main/controllers/edit_task_controller.dart';
import 'package:get/get.dart';

class EdittaskScreen extends GetView<EditTaskController> {
  const EdittaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Edit-Task')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const SizedBox(height: 25),
              Form(
                key: controller.newformKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hint: Text(''),
                        label: Text('Title'),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 1.5,
                          ),
                        ),
                      ),
                      controller: controller.newTitleController,
                      validator: controller.validateAllForms,

                      onTap: () {},
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      decoration: InputDecoration(
                        hint: Text('Enter new destription'),
                        label: Text('Destrition'),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 1.5,
                          ),
                        ),
                      ),
                      controller: controller.newDescriptionController,
                      validator: controller.validateAllForms,
                    ),
                    //
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.calendar_month_outlined),
                        label: Text('Date'),
                        hint: Text('Day / Month / Year'),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 1.5,
                          ),
                        ),
                      ),
                      controller: controller.newDueDateController,
                      validator: controller.validateAllForms,
                      onTap: () => pickDate(
                        controller.selectedDate,
                        controller.newDueDateController,
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.credit_score_sharp),
                        label: Text('Xp Value'),
                        hint: Text('0'),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 1.5,
                          ),
                        ),
                      ),
                      controller: controller.newXpValueController,
                      validator: controller.validateAllForms,
                    ),
                  ],
                ),
              ).marginOnly(bottom: 100),

              // const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  // final addTaskController = AddTaskController();
                  // final tasksController = TasksController();
                  controller.updatedTask();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.green),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.green,
                  ),
                  child: Center(
                    child: Text(
                      'Edit-Task',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
