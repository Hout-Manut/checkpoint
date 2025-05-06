import 'package:checkpoint/models/split_time_model.dart';

class Checkpoint {
  final String raceId;
  final String splitId;
  List<SplitTime> splitTimes = [];

  Checkpoint({required this.raceId, required this.splitId});
}
