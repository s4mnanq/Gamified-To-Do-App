import 'package:contribution_heatmap/contribution_heatmap.dart';
import 'package:flutter/material.dart';
import 'package:gamified_todo_app/core/errors/api_exception.dart';
import 'package:gamified_todo_app/core/errors/error_handler.dart';
import 'package:gamified_todo_app/core/utils/logger.dart';
import 'package:gamified_todo_app/core/utils/snackbar_utils.dart';
import 'package:gamified_todo_app/repositories/calendar_repository.dart';
import 'package:get/get.dart';

class CalendarController extends GetxController {
  final calendarRepo = Get.find<CalendarRepository>();

  final quarters = <List<ContributionEntry>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchYearlyActivity();
  }

  Future<void> fetchYearlyActivity() async {
    try {
      final yearlyEntries = <ContributionEntry>[];
      // await Future.delayed(const Duration(seconds: 1));

      // MOCK API DATA
      // final apiResponse = {
      //   "activities": {
      //     "2026-01-01": 1,
      //     "2026-02-14": 3,
      //     "2026-06-10": 5,
      //     "2026-11-17": 8,
      //   },
      // };

      final apiResponse = await calendarRepo.fetchYearlyActivity(
        DateTime.now().year,
      );

      final activityMap = parseApiActivity(apiResponse.data);

      yearlyEntries.addAll(
        generateYearlyEntries(DateTime.now().year, activityMap),
      );

      quarters.assignAll(splitByQuarter(yearlyEntries));
    } catch (e) {
      AppLogger.error(e.toString(), tag: 'CalendarController');
      final context = Get.context;
      if (context == null) return;
      if (context.mounted) {
        if (e is ApiException) {
          _handleApiException(e, context);
        } else {
          SnackbarUtils.showError(
            context,
            message: 'An unexpected error occurred. Please try again.',
          );
        }
      }
    }
  }
}

void _handleApiException(ApiException exception, BuildContext context) {
  String? message;
  if (ApiErrorHandler.hasDetails(exception)) {
    message = ApiErrorHandler.getDetail(exception, 'password');
  } else {
    message = ApiErrorHandler.getErrorMessage(exception);
  }
  if (message != null) {
    SnackbarUtils.showError(context, message: message);
  }
}

Map<DateTime, int> parseApiActivity(Map<String, dynamic> json) {
  final Map<DateTime, int> map = {};

  json['activities'].forEach((key, value) {
    final date = DateTime.parse(key);
    map[DateTime(date.year, date.month, date.day)] = value;
  });

  return map;
}

List<List<ContributionEntry>> splitByQuarter(List<ContributionEntry> entries) {
  return [
    entries.where((e) => e.date.month <= 3).toList(),
    entries.where((e) => e.date.month >= 4 && e.date.month <= 6).toList(),
    entries.where((e) => e.date.month >= 7 && e.date.month <= 9).toList(),
    entries.where((e) => e.date.month >= 10).toList(),
  ];
}

List<ContributionEntry> generateYearlyEntries(
  int year,
  Map<DateTime, int> activityMap,
) {
  final start = DateTime(year, 1, 1);
  final end = DateTime(year + 1, 1, 1);

  final entries = <ContributionEntry>[];
  var current = start;

  while (current.isBefore(end)) {
    final normalized = DateTime(current.year, current.month, current.day);

    entries.add(ContributionEntry(normalized, activityMap[normalized] ?? 0));

    current = current.add(const Duration(days: 1));
  }

  return entries;
}
