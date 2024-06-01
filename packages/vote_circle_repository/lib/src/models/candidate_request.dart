import 'package:equatable/equatable.dart';
import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;

class CandidateRequest extends Equatable {
  final String candidate;

  const CandidateRequest({
    required this.candidate,
  });

  vote_circle_api.CandidateRequest toApiCandidateRequest() =>
      vote_circle_api.CandidateRequest(
        candidate: candidate,
      );

  @override
  List<Object> get props => [
        candidate,
      ];
}
