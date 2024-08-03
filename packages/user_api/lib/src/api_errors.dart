part of 'user_api_client.dart';

abstract class ApiFailure implements Exception {
  final int statusCode;
  final String? msg;
  final ResponseStatus? status;

  ApiFailure({
    required this.statusCode,
    this.msg,
    this.status,
  });
}

class ApiError implements Exception {
  final Object error;

  ApiError(this.error);
}

class QueryUserFailure extends ApiFailure {
  QueryUserFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}

class UpdateUserFailure extends ApiFailure {
  UpdateUserFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}

class UploadUserFailure extends ApiFailure {
  UploadUserFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}
