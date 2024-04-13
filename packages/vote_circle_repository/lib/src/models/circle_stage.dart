import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;

enum CircleStage {
  Cold,
  Hot,
  Closed,
}

CircleStage circleStageFromApiCircleStage(vote_circle_api.CircleStage stage) {
  switch (stage) {
    case vote_circle_api.CircleStage.Cold:
      return CircleStage.Cold;
    case vote_circle_api.CircleStage.Hot:
      return CircleStage.Hot;
    case vote_circle_api.CircleStage.Closed:
      return CircleStage.Closed;
  }
}
