import 'package:equatable/equatable.dart';
import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;

import 'user_private_option.dart';

class UserOption extends Equatable {
  final int maxCircles;
  final int maxVoters;
  final int maxCandidates;
  final UserPrivateOption privateOption;

  const UserOption({
    required this.maxCircles,
    required this.maxVoters,
    required this.maxCandidates,
    required this.privateOption,
  });

  factory UserOption.fromApiUserOption(vote_circle_api.UserOption option) =>
      UserOption(
        maxCircles: option.maxCircles,
        maxVoters: option.maxVoters,
        maxCandidates: option.maxCandidates,
        privateOption:
            UserPrivateOption.fromApiUserPrivateOption(option.privateOption),
      );

  @override
  List<Object?> get props => [
        maxCircles,
        maxVoters,
        maxCandidates,
        privateOption,
      ];
}
