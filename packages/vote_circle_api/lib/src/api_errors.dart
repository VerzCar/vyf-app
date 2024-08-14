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

class QueryRankingFailure extends ApiFailure {
  QueryRankingFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}

class QueryRankingsLastViewedFailure extends ApiFailure {
  QueryRankingsLastViewedFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}

class QueryCandidatesFailure extends ApiFailure {
  QueryCandidatesFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}

class QueryVotersFailure extends ApiFailure {
  QueryVotersFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}

class QueryUserOptionFailure extends ApiFailure {
  QueryUserOptionFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}

class QueryVotedByFailure extends ApiFailure {
  QueryVotedByFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}

class CreateCircleFailure extends ApiFailure {
  CreateCircleFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}

class UpdateCircleFailure extends ApiFailure {
  UpdateCircleFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}

class DeleteCircleFailure extends ApiFailure {
  DeleteCircleFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}

class JoinCircleFailure extends ApiFailure {
  JoinCircleFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}

class LeaveCircleFailure extends ApiFailure {
  LeaveCircleFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}

class CreateVoteFailure extends ApiFailure {
  CreateVoteFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}

class RevokeVoteFailure extends ApiFailure {
  RevokeVoteFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}

class RemoveVoteFailure extends ApiFailure {
  RemoveVoteFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}

class RemoveCandidateFailure extends ApiFailure {
  RemoveCandidateFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}

class AddVoteFailure extends ApiFailure {
  AddVoteFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}

class AddCandidateFailure extends ApiFailure {
  AddCandidateFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}

class UpdateCommitmentFailure extends ApiFailure {
  UpdateCommitmentFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}

class UploadFailure extends ApiFailure {
  UploadFailure({
    required super.statusCode,
    super.msg,
    super.status,
  });
}
