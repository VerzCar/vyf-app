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

  @override
  String toString() {
    return name;
  }

  CirclePaginated copyWith({
    int? id,
    String? name,
    String? description,
    String? imageSrc,
    int? votersCount,
    int? candidatesCount,
    bool? active,
    CircleStage? stage,
  }) {
    return CirclePaginated(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageSrc: imageSrc ?? this.imageSrc,
      votersCount: votersCount ?? this.votersCount,
      candidatesCount: candidatesCount ?? this.candidatesCount,
      active: active ?? this.active,
      stage: stage ?? this.stage,
    );
  }

  CirclePaginated from(CirclePaginated circle) {
    return CirclePaginated(
      id: circle.id,
      name: circle.name,
      description: circle.description,
      imageSrc: circle.imageSrc,
      votersCount: circle.votersCount,
      candidatesCount: circle.candidatesCount,
      active: circle.active,
      stage: circle.stage,
    );
  }

  factory CirclePaginated.fromApiCirclePaginated(
          vote_circle_api.CirclePaginated circle) =>
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
