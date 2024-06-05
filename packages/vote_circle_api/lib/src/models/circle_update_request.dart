import 'package:json_annotation/json_annotation.dart';

import 'date_time_converter.dart';

part 'circle_update_request.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class CircleUpdateRequest {
  final String? name;
  final String? description;
  final bool? private;
  @DateTimeConverter()
  final DateTime? validFrom;
  @DateTimeConverter()
  final DateTime? validUntil;

  CircleUpdateRequest({
    this.name,
    this.description,
    this.private,
    this.validFrom,
    this.validUntil,
  });

  factory CircleUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$CircleUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CircleUpdateRequestToJson(this);
}
