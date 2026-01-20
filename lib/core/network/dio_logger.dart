import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioLogger extends Interceptor {
  static const int _maxLength = 1000;
  static const String _redacted = '***';
  static const Set<String> _sensitiveKeys = {
    'authorization',
    'token',
    'access_token',
    'refresh_token',
    'password',
    'secret',
    'api_key',
    'apikey',
    'cookie',
    'set-cookie',
    'session',
  };
  bool get _enabled => kDebugMode;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_enabled) {
      log('REQUEST: ${options.method} ${options.uri}');
      log('Headers: ${_sanitizeHeaders(options.headers)}');
      log('Query: ${options.queryParameters}');
      log('Body: ${_pretty(_sanitizeData(options.data))}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (_enabled) {
      log('RESPONSE [${response.statusCode}]: ${response.requestOptions.uri}');
      log('Data: ${_pretty(_sanitizeData(response.data))}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (_enabled) {
      log(
        'ERROR [${err.response?.statusCode ?? 'N/A'}]: ${err.requestOptions.uri}',
      );
      log('Data: ${_pretty(_sanitizeData(err.response?.data))}');
      log('Message: ${err.message}');
    }
    handler.next(err);
  }

  Map<String, dynamic> _sanitizeHeaders(Map<String, dynamic> headers) {
    return _sanitizeMap(headers);
  }

  dynamic _sanitizeData(dynamic data) {
    if (data is Map) {
      return _sanitizeMap(data);
    }
    if (data is List) {
      return data.map(_sanitizeData).toList();
    }
    return data;
  }

  Map<String, dynamic> _sanitizeMap(Map<dynamic, dynamic> map) {
    final result = <String, dynamic>{};
    map.forEach((key, value) {
      final keyString = key.toString();
      final lowerKey = keyString.toLowerCase();
      if (_sensitiveKeys.any(lowerKey.contains)) {
        result[keyString] = _redacted;
      } else {
        result[keyString] = _sanitizeData(value);
      }
    });
    return result;
  }

  String _pretty(dynamic data) {
    if (data == null) return 'null';
    try {
      final jsonStr = const JsonEncoder.withIndent('  ').convert(data);
      return jsonStr.length > _maxLength
          ? '${jsonStr.substring(0, _maxLength)}...'
          : jsonStr;
    } catch (_) {
      return data.toString();
    }
  }
}
