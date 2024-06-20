import 'dart:core';

enum ResponseStatus {
  nop,
  success,
  error,
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

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        status: _enumDecode(_responseStatusEnumMap, json['status']),
        msg: json['msg'] as String,
        data: json['data'] as T,
      );
}

// Helper function to convert enum to string
String responseStatusToString(ResponseStatus status) {
  switch (status) {
    case ResponseStatus.nop:
      return 'nop';
    case ResponseStatus.success:
      return 'success';
    case ResponseStatus.error:
      return 'error';
    default:
      return '';
  }
}

// Helper function to convert string to enum
ResponseStatus stringToResponseStatus(String status) {
  switch (status) {
    case 'nop':
      return ResponseStatus.nop;
    case 'success':
      return ResponseStatus.success;
    case 'error':
      return ResponseStatus.error;
    default:
      throw ArgumentError('Invalid ResponseStatus string');
  }
}

const _responseStatusEnumMap = {
  ResponseStatus.nop: 'nop',
  ResponseStatus.error: 'error',
  ResponseStatus.success: 'success'
};

K _enumDecode<K extends Enum, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  for (var entry in enumValues.entries) {
    if (entry.value == source) {
      return entry.key;
    }
  }

  if (unknownValue == null) {
    throw ArgumentError(
      '`$source` is not one of the supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return unknownValue;
}
