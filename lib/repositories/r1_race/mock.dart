import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:checkpoint/entities/dtos/race_dto.dart';
import 'package:checkpoint/entities/models/participant_model.dart';
import 'package:checkpoint/entities/models/race_model.dart';
import 'package:checkpoint/entities/models/race_split_model.dart';
import 'package:checkpoint/repositories/r1_race/base.dart';

class MockRaceRepo extends RaceRepo {
  final List<Race> _availableRaces = [];
  final Map<String, List<void Function(Race)>> _subscribers = {};
  MockRaceRepo() {
    loadData();
  }

  // void _notifyListeners(Race race) {
  //   for (final subscriber in _subscribers[race.id] ?? []) {
  //     subscriber(race);
  //   }
  // }

  Future<void> loadData() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/mock_data.json',
    );
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    _availableRaces.clear();
    for (final data in (jsonData['races'] as Map<String, dynamic>).entries) {
      _availableRaces.add(RaceDto.fromJson(data.key, data.value));
    }
  }

  @override
  String create(Race race) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> finish({required String raceId, required DateTime time}) {
    // _notifyListeners(race)
    throw UnimplementedError();
  }

  @override
  Future<Race> read({required String raceId}) async {
    for (Race race in _availableRaces) {
      if (race.id == raceId) {
        return race;
      }
    }
    throw Exception('No race with id $raceId found.');
  }

  @override
  Future<void> reset({required String raceId}) {
    // TODO: implement reset
    throw UnimplementedError();
  }

  @override
  Future<void> start({
    required String raceId,
    required DateTime time,
  }) {
    // TODO: implement start
    throw UnimplementedError();
  }

  @override
  void watch({
    required String raceId,
    required void Function(Race race) onChange,
  }) async {
    Race race = await read(raceId: raceId);

    if (_subscribers[raceId] == null) {
      _subscribers[raceId] = [];
    }
    _subscribers[raceId]!.add(onChange);
    onChange(race);
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
  }) {
    // TODO: implement update
  }

  @override
  Future<List<Race>> getAllRaces({required String userId}) async {
    return _availableRaces;
  }
}
