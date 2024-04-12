part of 'vote_circle_api_client.dart';

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

class QueryCircleFailure extends ApiFailure {
  QueryCircleFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}

