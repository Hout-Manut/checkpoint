import 'package:checkpoint/entities/dtos/participant_dto.dart';
import 'package:checkpoint/entities/dtos/split_dto.dart';
import 'package:checkpoint/entities/models/participant_model.dart';
import 'package:checkpoint/entities/models/race_model.dart';
import 'package:checkpoint/entities/models/race_split_model.dart';

class RaceDto {
  static Race fromJson(String id, Map<String, dynamic> json) {
    String name = json['name'];
    int dateValue = json['raceDate'];
    int? startTimeValue = json['startTime'];
    int? finishTimeValue = json['finishTime'];

    List<Participant> participants = [];

    for (final participant
        in (Map<String, dynamic>.from(json["participants"] ?? {})).entries) {
      participants.add(
        ParticipantDto.fromJson(
          participant.key,
          Map<String, dynamic>.from(participant.value ?? {}),
        ),
      );
    }

    List<RaceSplit> splits = [];

    for (final split
        in Map<String, dynamic>.from(json["splits"] ?? {}).entries) {
      splits.add(
        SplitDto.fromJson(
          split.key,
          Map<String, dynamic>.from(split.value ?? {}),
        ),
      );
    }

    return Race(
      id: id,
      name: name,
      raceDate: DateTime.fromMillisecondsSinceEpoch(dateValue),
      startTime:
          startTimeValue == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(startTimeValue),
      finishTime:
          finishTimeValue == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(finishTimeValue),
      participants: participants,
      splits: splits,
    );
  }

  static Map<String, dynamic> toJson(Race race) {
    Map<String, dynamic> participants = {};

    for (Participant part in race.participants) {
      participants[part.bib] = ParticipantDto.toJson(part);
    }
    Map<String, dynamic> splits = {};

    for (RaceSplit split in race.splits) {
      splits[split.id] = SplitDto.toJson(split);
    }

    return {
      'name': race.name,
      'raceDate': race.raceDate.millisecondsSinceEpoch,
      if (race.startTime != null)
        'startTime': race.startTime!.millisecondsSinceEpoch,
      if (race.finishTime != null)
        'finishTime': race.finishTime!.millisecondsSinceEpoch,
      'participants': participants,
      'splits': splits,
    };
  }
}
