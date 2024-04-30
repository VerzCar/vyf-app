import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/presentation/shared/widgets/models/label_position.dart';

final class UserAvatarOption {
  const UserAvatarOption({
    this.border = false,
    this.withLabel = false,
    this.labelPosition = LabelPosition.right,
    this.size = AvatarSize.base,
  });

  final bool border;
  final bool withLabel;
  final LabelPosition labelPosition;
  final AvatarSize size;
}
