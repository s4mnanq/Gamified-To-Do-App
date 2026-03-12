import 'package:flutter/material.dart';
import 'package:gamified_todo_app/modules/main/model/task_model.dart';
import 'package:gamified_todo_app/routes/app_routes.dart';
import 'package:get/get.dart';
import '../controllers/tasks_controller.dart';
part '../widgets/_task_button_widget.dart';

class TasksScreen extends GetView<TasksController> {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 99,
        // leading: GestureDetector(
        //   onTap: () {
        //     // Get.toNamed(AppRoutes.home);
        //     Get.back();
        //   },
        //   child: Row(
        //     children: [
        //       Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        //       SizedBox(width: 4),
        //       Text('Back', style: TextStyle(fontSize: 15)),
        //     ],
        //   ),
        // ),
        title: Text('Task'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Obx(() {
                final selectedCategoryIndex =
                    controller.selectedCategoryIndex.value;
                return SizedBox(
                  height: 56,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                    scrollDirection: .horizontal,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final category = controller.taskCategory[index];

                      ///----
                      return _TaskButtonWidget(
                        txtMessage: category.capitalizeFirst ?? category,
                        selectedCategoryIndex: selectedCategoryIndex,
                        currentIndex: index,
                      );
                    },
                    separatorBuilder: (_, _) => const SizedBox(width: 16),
                    itemCount: controller.taskCategory.length,
                  ),
                );
              }),
              // const SizedBox(height: 20),
              const SizedBox(height: 25),
              //
              Expanded(
                child: Obx(() {
                  if (controller.filteredTasks.isEmpty) {
                    return Center(child: Text('No Task'));
                  } else {
                    return ListView.builder(
                      scrollDirection: .vertical,
                      itemCount: controller.filteredTasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        //
                        final task = TaskModel.fromMap(
                          controller.filteredTasks[index],
                        );
                        final realIndex =
                            controller.filteredTasks[index]['_index'];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 3.3),
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  width: 2,
                                  color: Colors.green,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          task.title ?? 'Unknown',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          // maxLines: 1,
                                        ),
                                        Text(
                                          task.description ?? 'Unknown',
                                          style: TextStyle(fontSize: 11),
                                          overflow: TextOverflow.ellipsis,
                                          // maxLines: 2,
                                        ),
                                        Text(
                                          'Due : ${task.due}',
                                          style: TextStyle(fontSize: 11),
                                          overflow: TextOverflow.ellipsis,
                                          // maxLines: 1,
                                        ),
                                        Text(
                                          'Priority : ${task.priority}',
                                          style: TextStyle(fontSize: 11),
                                          overflow: TextOverflow.ellipsis,
                                          // maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // xp value
                                  //
                                  Row(
                                    children: [
                                      Text(
                                        task.xp ?? '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.cyan,
                                        ),
                                      ),
                                      Text(
                                        'Xp',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.cyan,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Get.toNamed(
                                            AppRoutes.editTask,
                                            arguments: {
                                              'task': task,
                                              'index': realIndex,
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          size: 19,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          debugPrint(
                                            'Deleted_Icons Index : $index ',
                                          );
                                          controller.deletedTask(realIndex);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.redAccent,
                                          size: 19,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
