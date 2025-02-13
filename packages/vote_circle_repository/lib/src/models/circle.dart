import 'package:const_date_time/const_date_time.dart';
import 'package:equatable/equatable.dart';
import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;
import 'package:vote_circle_repository/src/models/models.dart';

import 'circle_stage.dart';

class Circle extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imageSrc;
  final bool private;
  final bool active;
  final CircleStage stage;
  final String createdFrom;
  final DateTime validFrom;
  final DateTime? validUntil;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Circle({
    required this.id,
    required this.name,
    required this.description,
    required this.imageSrc,
    required this.private,
    required this.active,
    required this.stage,
    required this.createdFrom,
    required this.validFrom,
    this.validUntil,
    required this.createdAt,
    required this.updatedAt,
  });

  static const empty = Circle(
    id: 0,
    name: '',
    description: '',
    imageSrc: '',
    private: false,
    active: false,
    stage: CircleStage.closed,
    createdFrom: '',
    validFrom: ConstDateTime(2024),
    createdAt: ConstDateTime(2024),
    updatedAt: ConstDateTime(2024),
  );

  bool get isEmpty => this == Circle.empty;

  Circle copyWith({
    int? id,
    String? name,
    String? description,
    String? imageSrc,
    bool? private,
    bool? active,
    CircleStage? stage,
    String? createdFrom,
    DateTime? validFrom,
    DateTime? validUntil,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Circle(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageSrc: imageSrc ?? this.imageSrc,
      private: private ?? this.private,
      active: active ?? this.active,
      stage: stage ?? this.stage,
      createdFrom: createdFrom ?? this.createdFrom,
      validFrom: validFrom ?? this.validFrom,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Circle.fromApiCircle(vote_circle_api.Circle circle) => Circle(
        id: circle.id,
        name: circle.name,
        description: circle.description,
        imageSrc: circle.imageSrc,
        private: circle.private,
        active: circle.active,
        stage: circleStageFromApiCircleStage(circle.stage),
        createdFrom: circle.createdFrom,
        validFrom: circle.validFrom,
        validUntil: circle.validUntil,
        createdAt: circle.createdAt,
        updatedAt: circle.updatedAt,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageSrc,
        private,
        active,
        stage,
        createdFrom,
        validFrom,
        validUntil,
        createdAt,
        updatedAt,
      ];
}
