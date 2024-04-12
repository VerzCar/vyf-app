import 'package:json_annotation/json_annotation.dart';

enum ResponseStatus {
  Nop,
  Success,
  Error,
}

class ApiResponse<T> {
  final ResponseStatus status;
  final String msg;
  final T data;

  ApiResponse({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'status': ResponseStatus status,
        'msg': String msg,
        'data': T data,
      } =>
        ApiResponse(
          status: status,
          msg: msg,
          data: data,
        ),
      _ => throw const FormatException('Failed to load api response.'),
    };
  }
}

// Helper function to convert enum to string
String responseStatusToString(ResponseStatus status) {
  switch (status) {
    case ResponseStatus.Nop:
      return 'nop';
    case ResponseStatus.Success:
      return 'success';
    case ResponseStatus.Error:
      return 'error';
    default:
      return '';
  }
}

// Helper function to convert string to enum
ResponseStatus stringToResponseStatus(String status) {
  switch (status) {
    case 'nop':
      return ResponseStatus.Nop;
    case 'success':
      return ResponseStatus.Success;
    case 'error':
      return ResponseStatus.Error;
    default:
      throw ArgumentError('Invalid ResponseStatus string');
  }
}
