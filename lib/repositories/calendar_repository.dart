import 'package:dio/dio.dart';
import 'package:gamified_todo_app/core/constants/api_constants.dart';
import 'package:gamified_todo_app/core/errors/api_exception.dart';
import 'package:gamified_todo_app/core/network/dio_client.dart';
import 'package:gamified_todo_app/models/api_response.dart';
import 'package:get/get.dart';

class CalendarRepository {
  final DioClient _dioClient = Get.find<DioClient>();

  Future<ApiResponse<dynamic>> fetchYearlyActivity(int year) async {
    try {
      final response = await _dioClient.dio.get(
        ApiEndpoints.activities,
        queryParameters: {'year': year},
      );

      return ApiResponse.fromJson(response.data, null);
    } on DioException catch (e) {
      if (e.error is ApiException) throw e.error!;
      rethrow;
    }
  }
}
