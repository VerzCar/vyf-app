import 'package:flutter/material.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

final class UserAvatarOption {
  const UserAvatarOption({
    this.border = false,
    this.withLabel = false,
    this.labelPosition = LabelPosition.right,
    this.labelChild,
    this.size = AvatarSize.base,
    this.commitment,
  });

  final bool border;
  final bool withLabel;
  final LabelPosition labelPosition;
  final Widget? labelChild;
  final AvatarSize size;
  final Commitment? commitment;
}
