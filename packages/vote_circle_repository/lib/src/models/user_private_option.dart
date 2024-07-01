import 'package:equatable/equatable.dart';
import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;

class UserPrivateOption extends Equatable {
  final int maxVoters;
  final int maxCandidates;

  const UserPrivateOption({
    required this.maxVoters,
    required this.maxCandidates,
  });

  static const empty = UserPrivateOption(
    maxVoters: 0,
    maxCandidates: 0,
  );

  factory UserPrivateOption.fromApiUserPrivateOption(
          vote_circle_api.UserPrivateOption option) =>
      UserPrivateOption(
        maxVoters: option.maxVoters,
        maxCandidates: option.maxCandidates,
      );

  @override
  List<Object?> get props => [
        maxVoters,
        maxCandidates,
      ];
}
