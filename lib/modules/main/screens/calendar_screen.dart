import 'package:contribution_heatmap/contribution_heatmap.dart';
import 'package:flutter/material.dart';
import 'package:gamified_todo_app/theme/theme.dart';
import 'package:gamified_todo_app/theme/theme_extensions.dart';
import 'package:get/get.dart';

import '../controllers/calendar_controller.dart';

class CalendarScreen extends GetView<CalendarController> {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Calender Screen')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const .symmetric(horizontal: 24, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Yearly Progress', style: context.textTheme.titleMedium),

                  const SizedBox(width: 8),

                  Icon(Icons.calendar_month_outlined, color: context.primary),
                ],
              ).marginOnly(bottom: 16),

              Container(
                padding: const .symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppTheme.mediumGray.withValues(alpha: 0.5),
                ),

                child: SizedBox(),
              ).marginOnly(bottom: 16),

              Obx(() {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.quarters.length,
                  itemBuilder: (_, index) {
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        // 13 weeks in a quarter
                        // in one quarter has 3 months base on controller logic
                        // so in 3 months there are 13 weeks
                        const weeksInQuarter = 13;

                        // Decide how many "units" total (cells + spacing)
                        final maxWidth = constraints.maxWidth;

                        // Compute base cell size
                        // Why * 1.2 ? to account for spacing between cells
                        // 1 cell + 0.2 spacing
                        double cellSize = maxWidth / (weeksInQuarter * 1.2);

                        // Clamp cell size for usability
                        // this .clamp(min, max) ensures the cell size stays within a reasonable range
                        // it helps maintain readability and usability across different screen sizes
                        // base on constraints size of the parent widget
                        // this means the final cellSize value is LIMITED between 12.0 and 20.0
                        cellSize = cellSize.clamp(12.0, 20.0);

                        // Spacing derived from cell size
                        final cellSpacing = (cellSize * 0.15).clamp(1.5, 3.0);

                        return Center(
                          child: ContributionHeatmap(
                            cellSize: cellSize,
                            cellSpacing: cellSpacing,
                            padding: EdgeInsets.zero,
                            entries: controller.quarters[index],
                          ),
                        ).marginOnly(right: 16);
                      },
                    );
                  },
                  separatorBuilder: (_, _) => const SizedBox(height: 24),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
