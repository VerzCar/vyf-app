import 'package:equatable/equatable.dart';
import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;
import 'circle_stage.dart';

class CirclePaginated extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imageSrc;
  final int? votersCount;
  final int? candidatesCount;
  final bool active;
  final CircleStage stage;

  const CirclePaginated({
    required this.id,
    required this.name,
    required this.description,
    required this.imageSrc,
    this.votersCount,
    this.candidatesCount,
    required this.active,
    required this.stage,
  });

  factory CirclePaginated.fromApiCirclePaginated(vote_circle_api.CirclePaginated circle) =>
      CirclePaginated(
        id: circle.id,
        name: circle.name,
        description: circle.description,
        imageSrc: circle.imageSrc,
        active: circle.active,
        stage: circleStageFromApiCircleStage(circle.stage),
        votersCount: circle.votersCount,
        candidatesCount: circle.candidatesCount,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageSrc,
        votersCount,
        candidatesCount,
        active,
        stage
      ];
}
