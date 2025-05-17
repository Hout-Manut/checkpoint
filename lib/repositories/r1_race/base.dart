import 'package:checkpoint/entities/models/participant_model.dart';
import 'package:checkpoint/entities/models/race_model.dart';
import 'package:checkpoint/entities/models/race_split_model.dart';

abstract class RaceRepo {
  Future<List<Race>> getAllRaces({required String userId});

  void watch({
    required String raceId,
    required void Function(Race race) onChange,
  });

  Future<Race> read({required String raceId});

  void start({required String raceId, required DateTime time});

  void finish({required String raceId, required DateTime time});

  void reset({required String raceId});

  void create(Race race);

  void update({
    required String raceId,
    DateTime? raceDate,
    DateTime? startTime,
    DateTime? finishTime,
    List<RaceSplit>? splits,
    bool addSplits = false,
    List<Participant>? participants,
    bool addParticipants = false,
  });
}
