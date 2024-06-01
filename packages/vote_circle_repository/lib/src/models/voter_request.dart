import 'package:equatable/equatable.dart';
import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;

class VoterRequest extends Equatable {
  final String voter;

  const VoterRequest({
    required this.voter,
  });

  vote_circle_api.VoterRequest toApiVoterRequest() =>
      vote_circle_api.VoterRequest(
        voter: voter,
      );

  @override
  List<Object> get props => [
        voter,
      ];
}
