// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'circle_candidate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CircleCandidate _$CircleCandidateFromJson(Map<String, dynamic> json) =>
    CircleCandidate(
      candidates: (json['candidates'] as List<dynamic>)
          .map((e) => Candidate.fromJson(e as Map<String, dynamic>))
          .toList(),
      userCandidate: json['userCandidate'] == null
          ? null
          : Candidate.fromJson(json['userCandidate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CircleCandidateToJson(CircleCandidate instance) =>
    <String, dynamic>{
      'candidates': instance.candidates,
      'userCandidate': instance.userCandidate,
    };
