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

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        status: _enumDecode(_responseStatusEnumMap, json['status']),
        msg: json['msg'] as String,
        data: json['data'] as T,
      );
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

const _responseStatusEnumMap = {
  ResponseStatus.Nop: 'nop',
  ResponseStatus.Error: 'error',
  ResponseStatus.Success: 'success'
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
