import 'package:checkpoint/models/participant_model.dart';
import 'package:checkpoint/models/race_split_model.dart';

class Race {
  final String raceId;
  final String name;
  final DateTime raceDate;
  final DateTime? startTime;
  final DateTime? dateTime;
  List<Participant> paticipants = [];
  List<RaceSplit> splits = [];

  Race({
    required this.raceId,
    required this.name,
    required this.raceDate,
    required this.startTime,
    required this.dateTime,
  });
}
