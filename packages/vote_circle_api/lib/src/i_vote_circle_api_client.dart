import 'models/models.dart';

abstract class IVoteCircleApiClient {
  Future<Circle> fetchCircle(int id);

  Future<List<Circle>> fetchCircles();

  Future<List<CirclePaginated>> fetchCirclesOfInterest();
}
