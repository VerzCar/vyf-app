import 'package:equatable/equatable.dart';
import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;

import 'candidate_request.dart';
import 'voter_request.dart';

class CircleCreateRequest extends Equatable {
  final String name;
  final String? description;
  final String? imageSrc;
  final List<CandidateRequest> candidates;
  final List<VoterRequest> voters;
  final bool? private;
  final DateTime? validFrom;
  final DateTime? validUntil;

  const CircleCreateRequest({
    required this.name,
    this.description,
    this.imageSrc,
    required this.candidates,
    required this.voters,
    this.private,
    this.validFrom,
    this.validUntil,
  });

  vote_circle_api.CircleCreateRequest toApiCircleCreateRequest() =>
      vote_circle_api.CircleCreateRequest(
        name: name,
        description: description,
        imageSrc: imageSrc,
        candidates: candidates
            .map((candidate) => candidate.toApiCandidateRequest())
            .toList(),
        voters: voters.map((voter) => voter.toApiVoterRequest()).toList(),
        private: private,
        validFrom: validFrom,
        validUntil: validUntil,
      );

  @override
  List<Object?> get props => [
        name,
        description,
        imageSrc,
        candidates,
        voters,
        private,
        validFrom,
        validUntil,
      ];
}
