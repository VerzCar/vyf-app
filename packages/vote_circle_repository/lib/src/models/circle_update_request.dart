import 'package:equatable/equatable.dart';
import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;

class CircleUpdateRequest extends Equatable {
  final String? name;
  final String? description;
  final bool? private;
  final DateTime? validFrom;
  final DateTime? validUntil;

  const CircleUpdateRequest({
    required this.name,
    this.description,
    this.private,
    this.validFrom,
    this.validUntil,
  });

  vote_circle_api.CircleUpdateRequest toApiCircleUpdateRequest() =>
      vote_circle_api.CircleUpdateRequest(
        name: name,
        description: description,
        private: private,
        validFrom: validFrom,
        validUntil: validUntil,
      );

  @override
  List<Object?> get props => [
        name,
        description,
        private,
        validFrom,
        validUntil,
      ];
}
