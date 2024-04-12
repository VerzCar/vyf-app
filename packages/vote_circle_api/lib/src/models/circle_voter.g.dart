// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'circle_voter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CircleVoter _$CircleVoterFromJson(Map<String, dynamic> json) => CircleVoter(
      voters: (json['voters'] as List<dynamic>)
          .map((e) => Voter.fromJson(e as Map<String, dynamic>))
          .toList(),
      userVoter: json['userVoter'] == null
          ? null
          : Voter.fromJson(json['userVoter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CircleVoterToJson(CircleVoter instance) =>
    <String, dynamic>{
      'voters': instance.voters,
      'userVoter': instance.userVoter,
    };
