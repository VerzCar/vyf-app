enum Placement {
  neutral,
  ascending,
  descending,
}

Placement placementFromEvent(String placement) {
  switch (placement) {
    case 'NEUTRAL':
      return Placement.neutral;
    case 'ASCENDING':
      return Placement.ascending;
    case 'DESCENDING':
      return Placement.descending;
    default:
      return Placement.neutral;
  }
}
