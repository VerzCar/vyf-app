import 'package:equatable/equatable.dart';
import 'voter.dart';

class CircleVoter extends Equatable {
  final List<Voter> voters;
  final Voter? userVoter;

  const CircleVoter({
    required this.voters,
    this.userVoter,
  });

  @override
  List<Object?> get props => [
        voters,
        userVoter,
      ];
}
