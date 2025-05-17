import 'package:checkpoint/entities/enums/sport_type.dart';

class RaceSplit {
  final String id;
  final String name;
  final double distance;
  final Sport sport;

  RaceSplit({
    required this.id,
    required this.name,
    required this.distance,
    required this.sport,
  });
}
