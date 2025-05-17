import 'package:checkpoint/entities/enums/race_state.dart';
import 'package:checkpoint/entities/models/participant_model.dart';
import 'package:checkpoint/entities/models/race_split_model.dart';

class Race {
  final String id;
  final String name;
  final DateTime raceDate;
  final DateTime? startTime;
  final DateTime? finishTime;

  final List<Participant> participants;
  final List<RaceSplit> splits;

  Race({
    required this.id,
    required this.name,
    required this.raceDate,
    required this.startTime,
    required this.finishTime,
    required this.participants,
    required this.splits,
  });

  RaceSplit getSplitById(String splitId) {
    for (RaceSplit split in splits) {
      if (split.id == splitId) return split;
    }
    throw Exception('Cannot find split with id $splitId for the current race.');
  }

  RaceState get state {
    if (startTime == null) {
      return RaceState.notStarted;
    } else if (finishTime == null) {
      return RaceState.onGoing;
    }
    return RaceState.finished;
  }

  double get totalDistance {
    double distance = 0;
    for (RaceSplit split in splits) {
      distance += split.distance / 1000;
    }
    return distance;
  }
}
