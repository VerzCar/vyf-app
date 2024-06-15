import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/application/circle/bloc/circle_bloc.dart';

class CircleSelector {
  /// Determines if the current user can edit the circle.
  static bool canEdit(
    CircleState circleState,
    String userIdentityId,
  ) {
    return circleState.status == StatusIndicator.success &&
        circleState.circle.createdFrom == userIdentityId &&
        circleState.circle.active &&
        circleState.circle.stage != CircleStage.Closed;
  }
}
