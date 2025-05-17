// Not to be confused with the app name.

class SplitTime {
  final String bib;
  final DateTime? time;
  SplitTime({
    required this.bib,
    required this.time,
  });

  @override
  String toString() {
    return 'SplitTime($bib, $time)';
  }
}

class Checkpoint {
  final String raceId;
  final String splitId;
  final List<SplitTime> splitTimes;

  Checkpoint({required this.raceId, required this.splitId, required this.splitTimes});
}
