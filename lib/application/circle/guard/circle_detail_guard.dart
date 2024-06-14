import 'package:auto_route/auto_route.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/injection.dart';

// TODO: this guard is currently not used. Delete?
class CircleDetailGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final voteCircleRepository = sl<IVoteCircleRepository>();

    final circleId = resolver.route.pathParams.getInt('circleId', 0);

    if (circleId == 0) {
      //resolver.redirect(const CircleNotEligibleRoute());
    }

    final eligibleToBeInCircle =
        await voteCircleRepository.eligibleToBeInCircle(circleId);

    if (eligibleToBeInCircle) {
      resolver.next();
    } else {
      //resolver.redirect(const CircleNotEligibleRoute());
    }
  }
}
