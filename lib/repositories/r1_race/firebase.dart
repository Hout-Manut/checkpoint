import 'package:firebase_database/firebase_database.dart';
import 'package:checkpoint/entities/dtos/race_dto.dart';
import 'package:checkpoint/entities/models/participant_model.dart';
import 'package:checkpoint/entities/models/race_model.dart';
import 'package:checkpoint/entities/models/race_split_model.dart';
import 'package:checkpoint/repositories/r1_race/base.dart';

class FirebaseRaceRepo implements RaceRepo {
  final _db = FirebaseDatabase.instance.ref();

  @override
  void create(Race race) {
    // TODO: implement create
  }

  @override
  void finish({required String raceId, required DateTime time}) async {
    final snapshot = await _db.child('races/$raceId').get();
    final data = snapshot.value as Map?;

    final raceData = Map<String, dynamic>.from(data ?? {});
    if (raceData['finishTime'] != null) {
      throw Exception('Race already finished');
    }

    await _db.child('races/$raceId').update({
      'finishTime': time.millisecondsSinceEpoch,
    });
  }

  @override
  Future<Race> read({required String raceId}) async {
    final snapshot = await _db.child('races/$raceId').get();
    if (snapshot.exists) {
      final data = snapshot.value as Map?;
      if (data == null) throw Exception("Unable to get race data.");

      final race = Map<String, dynamic>.from(data);

      return RaceDto.fromJson(raceId, race);
    }
    throw Exception("Unable to get race data.");
  }

  @override
  void reset({required String raceId}) async {
    final snapshot = await _db.child('races/$raceId').get();
    final data = snapshot.value as Map?;

    final raceData = Map<String, dynamic>.from(data ?? {});
    if (raceData['startTime'] == null) {
      throw Exception('Race has not started');
    }

    await _db.child('races/$raceId').update({
      'startTime': null,
      'finishTime': null,
    });
  }

  @override
  void start({required String raceId, required DateTime time}) async {
    final snapshot = await _db.child('races/$raceId').get();
    final data = snapshot.value as Map?;

    final raceData = Map<String, dynamic>.from(data ?? {});
    if (raceData['startTime'] != null) {
      throw Exception('Race already started');
    }

    await _db.child('races/$raceId').update({
      'startTime': time.millisecondsSinceEpoch,
    });
  }

  @override
  void update({
    required String raceId,
    DateTime? raceDate,
    DateTime? startTime,
    DateTime? finishTime,
    List<RaceSplit>? splits,
    bool addSplits = false,
    List<Participant>? participants,
    bool addParticipants = false,
  }) async {
    // final snapshot = await _db.child('races/$raceId').get();
    // final data = snapshot.value as Map?;

    // final raceData = Map<String, dynamic>.from(data ?? {});
  }

  @override
  void watch({
    required String raceId,
    required void Function(Race race) onChange,
  }) {
    _db.child('races/$raceId').onValue.listen((event) {
      final data = event.snapshot.value as Map?;

      if (data is Map) {
        Race newRace = RaceDto.fromJson(
          raceId,
          Map<String, dynamic>.from(data),
        );

        onChange(newRace);
      }
    });
  }

  @override
  Future<List<Race>> getAllRaces({required String userId}) async {

    final snapshot = await _db.child('managers/$userId').get();

    if (!snapshot.exists) return [];

    final List<String> raceIds = [];

    final data = Map<String, dynamic>.from(snapshot.value as Map? ?? {});
    for (final race in data.entries) {
      raceIds.add(race.key);
    }

    final List<Race> races = [];

    for (String raceId in raceIds) {
      races.add(await read(raceId: raceId));
    }

    return races;
  }
}
