import 'package:flutter/material.dart';
import 'package:gamified_todo_app/core/utils/date_picker.dart';
import 'package:gamified_todo_app/modules/main/controllers/add_task_controller.dart';

import 'package:get/get.dart';
part '../widgets/priority_widget.dart';

class AddtaskScreen extends GetView<AddTaskController> {
  const AddtaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Task')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 25),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.titleController,
                        decoration: InputDecoration(
                          label: Text('Title'),
                          hint: Text(' Enter Task name'),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
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
                        validator: controller.validateAllForms,
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        controller: controller.descriptionController,
                        onChanged: (value) {
                          debugPrint('description value $value');
                        },
                        autofocus: true,
                        decoration: InputDecoration(
                          label: Text('Description'),
                          hint: Text(' Enter more detail'),
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
                        validator: controller.validateAllForms,
                      ),
                      const SizedBox(height: 25),

                      // const SizedBox(height: 25),
                      //Picked Date
                      TextFormField(
                        readOnly: true, //
                        controller: controller.dueDateController,

                        decoration: InputDecoration(
                          labelText: 'Due',
                          hint: Text('Day / Month / Year'),
                          prefixIcon: Icon(Icons.calendar_month_outlined),
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
                        validator: controller.validateAllForms,
                        onTap: () => pickDate(
                          controller.selectedDate,
                          controller.dueDateController,
                        ),
                      ),
                      const SizedBox(height: 25),
                      //
                      Obx(() {
                        final selectedPriorityIndex =
                            controller.selectedPriorityIndex.value;
                        return SizedBox(
                          height: 56,
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 16);
                            },
                            scrollDirection: .horizontal,
                            itemCount: controller.priorityCategory.length,
                            itemBuilder: (context, int index) {
                              //
                              final priority =
                                  controller.priorityCategory[index];
                              //
                              return _PriorityWidgetButton(
                                txtMessage: priority.capitalize ?? priority,
                                currentIndex: index,
                                selectedCategoryIndex: selectedPriorityIndex,
                              );
                            },
                          ),
                        );
                      }),

                      const SizedBox(height: 25),
                      TextFormField(
                        controller: controller.xpValueController,
                        decoration: InputDecoration(
                          label: Text('Value Xp'),
                          hint: Text('0'),
                          prefixIcon: Icon(Icons.input_rounded),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: controller.validateAllForms,
                      ),
                    ],
                  ),
                ),
                // Priority Section
                const SizedBox(height: 60.0),
                // button cancell
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("Cancel Button");
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width * 0.415,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.green),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(child: Text('Cancel')),
                      ),
                    ),
                    // Button Create
                    GestureDetector(
                      onTap: () {
                        // controller.submiteValidate();
                        controller.addedTask();
                        // print("\n${controller.titleController.text}");
                        // print(controller.descriptionController.text);
                        // print(controller.dueDateController.text);
                        // print(controller.xpValueController.text);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width * 0.415,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.green),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.green,
                        ),
                        child: Center(
                          child: Text(
                            'Create',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
