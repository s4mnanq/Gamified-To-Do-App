import 'package:flutter/material.dart';
import 'package:gamified_todo_app/core/utils/date_picker.dart';
import 'package:gamified_todo_app/modules/main/controllers/add_task_controller.dart';

import 'package:get/get.dart';
import 'package:shadow_log/shadow_log.dart';
part '../widgets/priority_widget.dart';

class AddTaskScreen extends GetView<AddTaskController> {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Task')),
      body: SizedBox.expand(
        child: SafeArea(
          child: Stack(
            children: [
              GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                behavior: HitTestBehavior.opaque,
                child: SingleChildScrollView(
                  padding: const .symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: controller.titleController,
                              onTapOutside: (_) =>
                                  FocusScope.of(context).unfocus(),
                              onChanged: (String title) {
                                debugPrint('title value : $title');
                              },
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
                              onTapOutside: (_) =>
                                  FocusScope.of(context).unfocus(),
                              onChanged: (value) {
                                debugPrint('description value $value');
                              },
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
                              readOnly: true,
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
                                height: 62,
                                child: ListView.separated(
                                  padding: .zero,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 16);
                                  },
                                  scrollDirection: .horizontal,
                                  itemCount: controller.priorityCategory.length,
                                  itemBuilder: (context, int index) {
                                    final priority =
                                        controller.priorityCategory[index];

                                    return _PriorityWidgetButton(
                                      txtMessage: priority,
                                      currentIndex: index,
                                      selectedCategoryIndex:
                                          selectedPriorityIndex,
                                      onTap: () =>
                                          controller.updatePriority(index),
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

                      // button cancel
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 10,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          ShadowLog.i("Cancel Button");
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
                    ),
                    const SizedBox(width: 12),
                    // Button Create
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // controller.submitValidate();
                          controller.addTask();
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
