import 'models/models.dart';

abstract class IVoteCircleApiClient {
  Future<Circle> fetchCircle(String id);

  Future<List<Circle>> fetchCircles();

  Future<List<CirclePaginated>> fetchCirclesOfInterest();
}
