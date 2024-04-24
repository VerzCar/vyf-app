import 'models/models.dart';

abstract class IVoteCircleRepository {
  Future<Circle> circle(int id);

  Future<List<Circle>> circles();

  Future<List<CirclePaginated>> circlesOfInterest();

  Future<List<Ranking>> rankings(int circleId);
}
