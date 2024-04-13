import 'models/models.dart';

abstract class IVoteCircleRepository {
  Future<Circle> circle(String id);

  Future<List<Circle>> circles();

  Future<List<CirclePaginated>> circlesOfInterest();
}
