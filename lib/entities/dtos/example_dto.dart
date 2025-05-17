import 'package:checkpoint/entities/models/participant_model.dart';

void main() {
  Map<String, dynamic> data = {
    "001": {"name": "Qiqi"},
    "asdqasd": {"name": "Qiqi"},
    "01f3ff23f": {"name": "Qiqi"},
    "8": {"name": "Qiqi"},
  };

  for (final dataEntry in data.entries) {
    final p1 = participantFromJson(dataEntry.key, dataEntry.value);
    print(p1.bib);
  }

  // Participant p1 = participantFromJson('001', data['001']);
  // print(data['001']);
}



Participant participantFromJson(String bib, Map<String, dynamic> map) {
  return Participant(bib: bib, name: map['name']);
}
