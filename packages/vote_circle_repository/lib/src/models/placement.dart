import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;

enum Placement {
  neutral,
  ascending,
  descending,
}

Placement placementFromApiPlacement(vote_circle_api.Placement placement) {
  switch (placement) {
    case vote_circle_api.Placement.neutral:
      return Placement.neutral;
    case vote_circle_api.Placement.ascending:
      return Placement.ascending;
    case vote_circle_api.Placement.descending:
      return Placement.descending;
  }
}