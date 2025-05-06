enum Sport { cycling, runnung, swimming }

class RaceSplit {
  final String id;
  final Sport sport;
  final String name;
  final double distance;

  RaceSplit({
    required this.id,
    required this.sport,
    required this.name,
    required this.distance,
  });
}
