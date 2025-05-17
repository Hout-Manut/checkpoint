import 'package:checkpoint/entities/models/participant_model.dart';

class ParticipantDto {
  static Participant fromJson(String key, Map<String, dynamic> json) {
    assert(json['name'] is String);
    return Participant(bib: key, name: json['name']);
  }

  static Map<String, String> toJson(Participant participant) {
    return {'name': participant.name};
  }
}
