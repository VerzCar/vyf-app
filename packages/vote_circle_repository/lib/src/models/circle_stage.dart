import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;

enum CircleStage {
  cold,
  hot,
  closed,
}

CircleStage circleStageFromApiCircleStage(vote_circle_api.CircleStage stage) {
  switch (stage) {
    case vote_circle_api.CircleStage.cold:
      return CircleStage.cold;
    case vote_circle_api.CircleStage.hot:
      return CircleStage.hot;
    case vote_circle_api.CircleStage.closed:
      return CircleStage.closed;
  }
}
